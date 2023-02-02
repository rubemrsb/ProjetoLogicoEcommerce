drop database ecommerce;

-- criar banco de de dados

create database ecommerce;
use ecommerce;

-- criar tabela cliente
drop table clients;
create table clients (
	idClient int auto_increment primary key,
    Fname varchar(15),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar (250),
    Birthdate date,
    constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment = 1;

-- criar tabela produto
-- size = dimensão/tamanho

create table product (
	idProduct int auto_increment primary key,
	Pname varchar (30),
	Classification_kids bool default false,
	Category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
	Score float default 0,
	Size varchar(10)
);
-- criar tabela pedido

create table orders (
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
		on update cascade
        
);

-- Pagamento – Pode ter cadastrado mais de uma forma de pagamento;

create table payments(
	idPayment int auto_increment,
    idClient int,
    typePayment enum ('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable float,
    primary key (idClient,idPayment)
);

-- criar tabela estoque

create table productStorage(
idProductStorage int auto_increment primary key,
StorageLocation varchar (255),
Quantity int default 0
);


-- criar tabela fornecedor

create table supplier (
idSupplier int auto_increment primary key,
SocialName varchar(255) not null,
CNPJ char(15) not null,
Contact char (11) not null,
constraint unique_supplier unique (CNPJ)
);

-- criar tabela vendedor

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    Location varchar(255),
    Contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);


-- criar as n pra n

create table productSeller (
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key	(idPseller, idPproduct),
    constraint fk_productseller_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_productseller_product foreign key (idPproduct) references product(idProduct)
);
desc productSeller;

create table productOrder(
idPOproduct int, 
idPOorder int,
poQuantity int default 1,
poStatus enum ('Disponível', 'Sem estoque') default 'Disponível',
primary key (idPOproduct, idPOorder),
constraint fk_productOrder_product foreign key (idPOproduct) references product (idProduct),
constraint fk_productOrder_order foreign key (idPOorder) references orders (idOrder)
);

create table storageLocation (
idLproduct int,
idLstorage int,
location varchar (255) not null,
primary key (idLproduct, idLstorage),
constraint fk_StorageLocation_product foreign key (idLproduct) references product (idProduct),
constraint fk_StorageLocation_storage foreign key (idLstorage) references productStorage (idProductStorage)
);

create table productSupplier(
idPsSupplier int,
idPsProduct int,
quantity int not null,
primary key (idPsSupplier, idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier (idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product (idProduct)
);


-- Cliente PJ e PF – Uma conta pode ser PJ ou PF, mas não pode ter as duas informações;

create table clients_pf(
idpf int auto_increment primary key,
idPessoaFisica int,
constraint fk_clientpf_idpessoafisica foreign key (idPessoaFisica) references clients (idClient)
);

create table clients_pj(
idpj int auto_increment primary key,
idPessoaJuridica int,
constraint fk_clientpj_idpessoajuridica foreign key (idPessoaJuridica) references clients (idClient)
);
-- Entrega – Possui status e código de rastreio;
create table delivery (
idDelivery int auto_increment primary key,
DeliveryStatus enum ('Ainda não enviado', 'A caminho','Entregue'),
DeliveryTrackCode varchar (100)
);

create table orderDelivery (
idODorders int,
idODDelivery int,
primary key (idODorders, idODDelivery),
constraint fk_order_delivery_order foreign key (idODorders) references orders (idOrder),
constraint fk_order_delivery_delivery foreign key (idODDelivery) references delivery (idDelivery)
);



-- Quantos pedidos foram feitos por cada cliente?

SELECT count(*) AS Pedidos, Fname FROM orders, clients
WHERE idOrderClient = idClient
GROUP BY Fname;

-- Algum vendedor também é fornecedor?

SELECT * FROM seller, supplier
WHERE seller.CNPJ = supplier.CNPJ;

-- Relação de produtos fornecedores e estoques;

SELECT * 
FROM product AS p, supplier AS s, productStorage AS psto, productSupplier AS psup, storageLocation as sl
WHERE p.idProduct = idPsProduct AND idPsSupplier = idSupplier AND sl.idLproduct = p.idProduct AND idLstorage = idProductStorage;

-- Relação de nomes dos fornecedores e nomes dos produtos;

SELECT SocialName AS Nome_Da_Empresa, Pname AS Nome_Do_Produto
FROM product AS p, supplier AS s, productSupplier AS ps
WHERE idProduct = idPsProduct AND  idPsSupplier = idSupplier;
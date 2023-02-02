desc clients;
insert into clients (fname, Minit, Lname, CPF, Address) values
	('Maria', 'M', 'Silva', 12345678911, 'rua silva de prata 29, carangola - cidade das flores'),
    ('Matheus', 'O', 'Pimentel', 98765432111, 'rua alaeda 289, Centro - Cidade das flores'),
    ('Ricardo', 'F', 'Silva', 45678913211, 'Avenida Alameda Vinha 1009, Centro - Cidade das flores'),
    ('Julia', 'S', 'França', 78912345611, 'rua laranjeiras 861, Centro - Cidade das flores'),
    ('Roberta', 'G', 'Assis', 98745632111, 'Avenida Koller 19, Centro - Cidade das Flores'),
    ('Isabela', 'M', 'Cruz', 12398745611, 'Rua alameda das flores 28, Centro - Cidade das flores');
    
    -- 'Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis'
insert into product (Pname, classification_kids, category, Score, size) values
	('Fone de ouvido', False, 'Eletrônico', '4', null),
    ('Barbie elsa', true, 'Brinquedos', 3, null),
    ('Body Carters', true, 'Vestimenta', 5, null),
    ('Microfone vedo - youtube', false, 'Eletrônico', 4, null),
    ('Sofá retrátil', false, 'Móveis', 3,'3x57x80'),
    ('Farinha de arroz', False, 'Alimentos', 2, null),
    ('Fire Stick Amazon', False, 'Eletrônico', 3, null);
    

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
	(1, default, 'compra via aplicativo', null, 1),
    (2, default, 'compra via aplicativo', 50, 0),
    (3, 'Confirmado', null, null, 1),
    (4, default, 'Compra via website', 150, 0);

select * from orders;

delete from productorder where idPOorder in (1,2);

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
	(1,5,2,null),
    (2,5,1,null),
    (3,6,1,null);
    
insert into productStorage (storageLocation, quantity) values
	('Rio de janeiro', 1000),
    ('Rio de janeiro', 500),
    ('São Paulo', 10),
    ('São Paulo', 100),
    ('São Paulo', 10),
    ('Brasilia', 60);
    
    
insert into storageLocation (idLproduct, idLstorage, location) values 
	(1, 2, 'RJ'),
    (2,6, 'GO');
    
    
insert into supplier (socialName, CNPJ, contact) values
	('Almeida e Filhos', 123456789123456, 83111111111),
    ('Eletrônicos Silva', 123456123456789, 83222222222),
    ('Eletrônicos Valma', 987654321654321, 83333333333);
    
    
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
	(1,1,500),
    (1,2,400),
    (2,4,633),
    (3,3,5),
    (2,5,10);
    
    
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
	('tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 83444444444),
    ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 83555555555),
    ('Kids World', null, 456789123654484, null, 'São Paulo', 83666666666);
    
insert into productSeller (idPseller, idPproduct, prodQuantity) values 
	(1,6, 80),
    (2,7,10);
    
    

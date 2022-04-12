//SPDX-License-Identifier: UNLICENSED 
pragma solidity >=0.5.0 < 0.9.0;

contract Ecommerce { 
    address payable public manager ;
    
    constructor() {
         manager = payable (msg.sender);
    }
    struct Product {
        uint Id;
        string name ;
        string discription;
        uint price ;
        uint quantity ;
        address payable seller;
        address  buyer;
         bool delivered;
        }
        Product[] public list ;
        modifier Contract_Distroyed {
            require(DISTROYED==false , "Contract Distroyed  ");
            _ ;}
            Product  product ;
    function register_product (string memory _name , string memory _disc , uint _price , uint _quantity) Contract_Distroyed public {
                 product.name = _name;
                 product.discription= _disc;
                 product.price= _price*10**18;
                 product.quantity= _quantity;
                 product.seller =payable ( msg.sender);
                 list.push ( product) ;
                 product.Id ++;
        }
     function buy (uint productid) Contract_Distroyed public payable {
         require (msg.value == list[productid].price , "please pay exact product price");
         require( msg.sender !=  list[productid].seller, "seller can not buy there own product" );
         require (list[productid].quantity > 0 , " Sorry product is out of stock ");
        list[productid].buyer = msg.sender; 
         list[productid].quantity --;
       }  
     function delivery (uint productid) Contract_Distroyed public   {
       require ( list[productid].buyer == msg.sender , "only buyer can conferm the delivery of product");
         list[productid].delivered=true;
         list[productid].seller. transfer(list[productid].price );
         //  products[_productId-1].seller.transfer(products[_productId-1].price)
     }
     bool public DISTROYED ;
    function Distroy () public  {
        require(msg.sender==manager," only manger can distroy");
       manager.transfer(address(this).balance);
       DISTROYED= true;
    }
    fallback( ) external payable {
       payable (msg.sender).transfer(msg.value);
     
    }
    
}

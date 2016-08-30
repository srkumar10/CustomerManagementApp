xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.xyzbank.com/schema/Customer";
(:: import schema at "../WSDLs/CustomerPS.wsdl" ::)
declare namespace ns2="urn:xyzbank:cust:schema:customer";
(:: import schema at "../../OUCCommon/WSDLs/CustomerService.wsdl" ::)

declare variable $inputDeleteCustomer as element() (:: element(*, ns1:CustomerIDInput) ::) external;

declare function local:func($inputDeleteCustomer as element() (:: element(*, ns1:CustomerIDInput) ::)) as element() (:: schema-element(ns2:customerid_input) ::) {
    <ns2:customerid_input>
        <customer_id>{fn:data($inputDeleteCustomer/CustomerID)}</customer_id>
    </ns2:customerid_input>
};

local:func($inputDeleteCustomer)

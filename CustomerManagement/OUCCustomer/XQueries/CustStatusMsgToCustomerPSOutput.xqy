xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.xyzbank.com/schema/Customer";
(:: import schema at "../WSDLs/CustomerPS.wsdl" ::)
declare namespace ns1="urn:xyzbank:cust:schema:customer";
(:: import schema at "../../OUCCommon/WSDLs/CustomerService.wsdl" ::)

declare variable $outputStatus as element() (:: schema-element(ns1:status_msg) ::) external;

declare function local:CustStatusMsgToCustomerPSOutput($outputStatus as element() (:: schema-element(ns1:status_msg) ::)) as element() (:: element(*, ns2:StatusMsg) ::) {
    <ns2:StatusMsg>
        <CustomerID>{fn:data($outputStatus/customer_id)}</CustomerID>
        <status>{fn:data($outputStatus/status)}</status>
    </ns2:StatusMsg>
};

local:CustStatusMsgToCustomerPSOutput($outputStatus)

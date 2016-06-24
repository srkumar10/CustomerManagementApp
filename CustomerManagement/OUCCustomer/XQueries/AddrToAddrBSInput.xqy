xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.xyzbank.com/schema/Customer";
(:: import schema at "../WSDLs/CustomerPS.wsdl" ::)
declare namespace ns2="urn:xyzbank:cust:schema:address";
(:: import schema at "../../OUCCommon/WSDLs/AddrValidationService.wsdl" ::)

declare variable $inputAddress as element() (:: schema-element(ns1:Customer) ::) external;

declare function local:AddrToAddrBSInput($inputAddress as element() (:: schema-element(ns1:Customer) ::)) as element() (:: schema-element(ns2:addrval_input) ::) {
    <ns2:addrval_input>
        <address_line>{fn:concat(fn:data($inputAddress/Address1),",", $inputAddress/Address2,",", fn:data($inputAddress/Address3))}</address_line>
        <state>{fn:data($inputAddress/State)}</state>
        <country>{fn:data($inputAddress/Country)}</country>
        <zip_code>{fn:data($inputAddress/ZipCode)}</zip_code>
    </ns2:addrval_input>
};

local:AddrToAddrBSInput($inputAddress)

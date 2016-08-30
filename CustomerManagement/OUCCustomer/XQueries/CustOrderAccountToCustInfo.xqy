xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="urn:xyzbank:cust:schema:account";
(:: import schema at "../../OUCCommon/WSDLs/CustomerAccountService.wsdl" ::)
declare namespace ns1="urn:xyzbank:cust:schema:customer";
(:: import schema at "../../OUCCommon/WSDLs/CustomerService.wsdl" ::)
declare namespace ns2="urn:xyzbank:cust:schema:order";
(:: import schema at "../../OUCCommon/WSDLs/CustomerOrderService.wsdl" ::)

declare variable $varCustomer as element() (:: schema-element(ns1:customer) ::) external;
declare variable $varOrders as element() (:: element(*, ns2:customer_order_output) ::) external;
declare variable $varAccount as element() (:: schema-element(ns3:account_output) ::) external;

declare function local:getCustomerInfo($varCustomer as element() (:: schema-element(ns1:customer) ::), 
                                       $varOrders as element() (:: element(*, ns2:customer_order_output) ::), 
                                       $varAccount as element() (:: schema-element(ns3:account_output) ::)) 
                                       as element() (:: schema-element(ns1:migrated_customer) ::) {
    <ns1:migrated_customer>
        <customer_id>{fn:data($varCustomer/customer_id)}</customer_id>
        <full_name>{fn:data($varCustomer/full_name)}</full_name>
        <date_of_birth>{fn:data($varCustomer/date_of_birth)}</date_of_birth>
        <email>{fn:data($varCustomer/email)}</email>
        <phone>{fn:data($varCustomer/phone)}</phone>
        <addr_line1>{fn:data($varCustomer/addr_line1)}</addr_line1>
        <addr_line2>{fn:data($varCustomer/addr_line2)}</addr_line2>
        {
            if ($varCustomer/addr_line3)
            then <addr_line3>{fn:data($varCustomer/addr_line3)}</addr_line3>
            else ()
        }
        {
            if ($varCustomer/addr_line4)
            then <addr_line4>{fn:data($varCustomer/addr_line4)}</addr_line4>
            else ()
        }
        <customer_accounts>
            <account>
                <account_id>{fn:data($varAccount/ns3:account_id)}</account_id>
                {
                    if ($varAccount/ns3:account_type)
                    then <account_type>{fn:data($varAccount/ns3:account_type)}</account_type>
                    else ()
                }
                {
                    if ($varAccount/ns3:account_name)
                    then <account_name>{fn:data($varAccount/ns3:account_name)}</account_name>
                    else ()
                }
                {
                    if ($varAccount/ns3:description)
                    then <description>{fn:data($varAccount/ns3:description)}</description>
                    else ()
                }
                {
                    if ($varAccount/ns3:investor_type)
                    then <investor_type>{fn:data($varAccount/ns3:investor_type)}</investor_type>
                    else ()
                }
                {
                    if ($varAccount/ns3:start_date)
                    then <start_date>{fn:data($varAccount/ns3:start_date)}</start_date>
                    else ()
                }
                {
                    if ($varAccount/ns3:brokerage_code)
                    then <brokerage_code>{fn:data($varAccount/ns3:brokerage_code)}</brokerage_code>
                    else ()
                }
                {
                    if ($varAccount/ns3:rebate_code)
                    then <rebate_code>{fn:data($varAccount/ns3:rebate_code)}</rebate_code>
                    else ()
                }
                {
                    if ($varAccount/ns3:trading_limit)
                    then <trading_limit>{fn:data($varAccount/ns3:trading_limit)}</trading_limit>
                    else ()
                }
                {
                    if ($varAccount/ns3:tax_number1)
                    then <credit_limit>{fn:data($varAccount/ns3:tax_number1)}</credit_limit>
                    else ()
                }
                {
                    if ($varAccount/ns3:account_status)
                    then <account_status>{fn:data($varAccount/ns3:account_status)}</account_status>
                    else ()
                }
                {
                    if ($varAccount/ns3:registration_details)
                    then <registration_details></registration_details>
                    else ()
                }
            </account>
        </customer_accounts>
        <customer_orders>
            {
                for $orders in $varOrders/ns2:orders
                return 
                <order>
                    <account_id>{fn:data($orders/ns2:account_id)}</account_id>
                    <instrument_code>{fn:data($orders/ns2:instrument_code)}</instrument_code>
                    <order_action>{fn:data($orders/ns2:order_action)}</order_action>
                    <price>{fn:data($orders/ns2:price)}</price>
                    <currency_code>{fn:data($orders/ns2:price_currency_code)}</currency_code>
                    {
                        if ($orders/ns2:quantity)
                        then <quantity>{fn:data($orders/ns2:quantity)}</quantity>
                        else ()
                    }
                    <date_created>{fn:data($orders/ns2:date_created)}</date_created>
                    {
                        if ($orders/ns2:brokerage_amount)
                        then <brokerage_amount>{fn:data($orders/ns2:brokerage_amount)}</brokerage_amount>
                        else ()
                    }
                    {
                        if ($orders/ns2:brokerage_code)
                        then <brokerage_code>{fn:data($orders/ns2:brokerage_code)}</brokerage_code>
                        else ()
                    }
                    {
                        if ($orders/ns2:brokerage_code)
                        then 
                            if ($orders/ns2:brokerage_percent)
                            then <brokerage_perc>{fn:data($orders/ns2:brokerage_percent)}</brokerage_perc>
                            else ()
                        else ()
                    }
                </order>
            }
        </customer_orders>
    </ns1:migrated_customer>
};

local:getCustomerInfo($varCustomer, $varOrders, $varAccount)

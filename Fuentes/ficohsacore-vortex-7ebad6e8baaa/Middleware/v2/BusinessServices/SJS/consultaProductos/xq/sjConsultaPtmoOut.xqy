xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaProductosResponse/ns0:PRODUCTS/ns0:PRODUCT" location="../xsd/sjConsultaProductos.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaProductos";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaProductos/xq/sjConsultaPtmoOut/";

declare function xf:sjConsultaPtmoOut($outputParameters1 as element(ns1:OutputParameters),
    $loanNumber as xs:string)
    as element() {
        <ns0:PRODUCT>
        	<ns0:TYPE>PTM</ns0:TYPE>
            <ns0:ID>{ $loanNumber }</ns0:ID>
            <ns0:SUCCESS_INDICATOR>{ data($outputParameters1/ns1:ERROR_CODE) }</ns0:SUCCESS_INDICATOR>
            {
            	if (data($outputParameters1/ns1:ERROR_CODE) = "SUCCESS") then (
            		<ns0:MESSAGE/>,
            		<ns0:ALT_ID/>,
            		<ns0:NAME>{ data($outputParameters1/ns1:LOAN_CUSTOMER_NAME) }</ns0:NAME>,
            		<ns0:CURRENCY>{ data($outputParameters1/ns1:CURRENCY) }</ns0:CURRENCY>,
            		<ns0:STATUS>ACTIVE</ns0:STATUS>
            	) else 
            	(
            		<ns0:MESSAGE>{ data($outputParameters1/ns1:ERROR_MESSAGE) }</ns0:MESSAGE>
            	)
            }
        </ns0:PRODUCT>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $loanNumber as xs:string external;

xf:sjConsultaPtmoOut($outputParameters1,
    $loanNumber)
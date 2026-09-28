(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGeneralPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/consultaGeneralPTMGTIn/";

declare function xf:consultaGeneralPTMGTIn($ProductNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:LOAN_ID>{ $ProductNumber }</ns0:LOAN_ID>
        </ns0:InputParameters>
};

declare variable $ProductNumber as xs:string external;

xf:consultaGeneralPTMGTIn($ProductNumber)
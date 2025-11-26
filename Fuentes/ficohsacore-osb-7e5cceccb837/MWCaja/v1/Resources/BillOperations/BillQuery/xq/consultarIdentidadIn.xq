(:: pragma bea:global-element-return element="ns0:consultar_identidad" location="../../../../BusinessServices/SegurosGT/PagoSeguro/wsdl/pagoBancoPS.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillQuery/xq/consultarIdentidadIn/";

declare function xf:consultarIdentidadIn($parameter as xs:string,
    $identidad as xs:string)
    as element(ns0:consultar_identidad) {
        <ns0:consultar_identidad>
            <ns0:cod_identifica_banco>{ data($parameter) }</ns0:cod_identifica_banco>
            <ns0:identidad>{ data($identidad) }</ns0:identidad>
        </ns0:consultar_identidad>
};

declare variable $parameter as xs:string external;
declare variable $identidad as xs:string external;

xf:consultarIdentidadIn($parameter,
    $identidad)
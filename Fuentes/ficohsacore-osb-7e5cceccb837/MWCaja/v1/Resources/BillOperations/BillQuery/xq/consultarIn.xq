(:: pragma bea:global-element-return element="ns0:consultar" location="../../../../BusinessServices/SegurosGT/PagoSeguro/wsdl/pagoBancoPS.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/BillQuery/xq/consultarIn/";

declare function xf:consultarIn($parameter as xs:string,
    $codPoliza as xs:string,
    $tipoConsulta as xs:string)
    as element(ns0:consultar) {
        <ns0:consultar>
            <ns0:cod_identifica_banco>{ data($parameter) }</ns0:cod_identifica_banco>
            <ns0:cod_busqueda>{ data($codPoliza) }</ns0:cod_busqueda>
            <ns0:tipo_busqueda>{ substring(data($tipoConsulta), 1, 1) }</ns0:tipo_busqueda>
        </ns0:consultar>
};

declare variable $parameter as xs:string external;
declare variable $codPoliza as xs:string external;
declare variable $tipoConsulta as xs:string external;

xf:consultarIn($parameter,
    $codPoliza,
    $tipoConsulta)
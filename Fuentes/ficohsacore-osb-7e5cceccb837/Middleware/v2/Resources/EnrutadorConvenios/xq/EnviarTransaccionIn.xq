(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CNV/enrutadorConveniosDB/xsd/EnviarTransaccion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/EnviarTransaccion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnrutadorConvenios/xq/EnviarTransaccionIn/";

declare function xf:EnviarTransaccionIn($requestData1 as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PX_XMLIN>{ $requestData1 }</ns0:PX_XMLIN>
        </ns0:InputParameters>
};

declare variable $requestData1 as xs:string external;

xf:EnviarTransaccionIn($requestData1)
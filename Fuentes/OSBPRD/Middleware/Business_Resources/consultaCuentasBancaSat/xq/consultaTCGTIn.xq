(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaTarjetaCreditoTypeRequest" location="../../consultasCliente/consultaPasivosCliente/consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "ConsultaTarjetaCreditoCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCuentasBancaSat/xq/consultaTCGTIn/";

declare function xf:consultaTCGTIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader),
    $CustomerID as xs:string)
    as element(ns0:ConsultaTarjetaCreditoTypeRequest) {
        <ns0:ConsultaTarjetaCreditoTypeRequest>
            <ns0:AUTHENTICATION>
                <ns0:USERNAME>{ data($autenticacionRequestHeader1/UserName) }</ns0:USERNAME>
                <ns0:PASSWORD>{ data($autenticacionRequestHeader1/Password) }</ns0:PASSWORD>
            </ns0:AUTHENTICATION>
            <ns0:PARAMETERS>
                <ns0:CUSTOMERID>{ $CustomerID }</ns0:CUSTOMERID>
            </ns0:PARAMETERS>
        </ns0:ConsultaTarjetaCreditoTypeRequest>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;
declare variable $CustomerID as xs:string external;

xf:consultaTCGTIn($autenticacionRequestHeader1,
    $CustomerID)
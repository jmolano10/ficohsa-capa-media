(:: pragma bea:global-element-parameter parameter="$consultaTarjetaCreditoTypeRequest" element="ns1:ConsultaTarjetaCreditoTypeRequest" location="../../../../../Business_Resources/consultasCliente/consultaPasivosCliente/consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "ConsultaTarjetaCreditoCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCClienteGT/xq/sjConsultaTCClienteGTHeaderIn/";

declare function xf:sjConsultaTCClienteGTHeaderIn($consultaTarjetaCreditoTypeRequest as element(ns1:ConsultaTarjetaCreditoTypeRequest),
    $region as xs:string)
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ data($consultaTarjetaCreditoTypeRequest/ns1:AUTHENTICATION/ns1:USERNAME[1]) }</UserName>
                <Password>{ data($consultaTarjetaCreditoTypeRequest/ns1:AUTHENTICATION/ns1:PASSWORD[1]) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ $region }</SourceBank>
                <DestinationBank>{ $region }</DestinationBank>
            </Region>
        </ns0:RequestHeader>
};

declare variable $consultaTarjetaCreditoTypeRequest as element(ns1:ConsultaTarjetaCreditoTypeRequest) external;
declare variable $region as xs:string external;

xf:sjConsultaTCClienteGTHeaderIn($consultaTarjetaCreditoTypeRequest,
    $region)

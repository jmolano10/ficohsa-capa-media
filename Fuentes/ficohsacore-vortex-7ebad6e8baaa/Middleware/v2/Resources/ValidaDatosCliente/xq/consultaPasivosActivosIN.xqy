xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaActivosPasivosCliente" location="../../../BusinessServices/SJS/consultaActivosPasivosCliente/xsd/sjConsultaActivosPasivosCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/consultaPasivosActivosIN/";

declare function xf:consultaPasivosActivosIN($requestHeaderIN as element(ns1:RequestHeader),
    $CustomerID as xs:string,
    $TypeSearch as xs:string,
    $AssetSearch as xs:string,
    $LiabilitySearch as xs:string)
    as element(ns0:sjConsultaActivosPasivosCliente) {
        <ns0:sjConsultaActivosPasivosCliente>
            <ns0:USERNAME>{ data($requestHeaderIN/Authentication/UserName) }</ns0:USERNAME>
            <ns0:PASSWORD>{ data($requestHeaderIN/Authentication/Password) }</ns0:PASSWORD>
            <ns0:SOURCE_BANK>{ data($requestHeaderIN/Region/SourceBank) }</ns0:SOURCE_BANK>
            <ns0:DESTINATION_BANK>{ data($requestHeaderIN/Region/DestinationBank)  }</ns0:DESTINATION_BANK>
            <ns0:CUSTOMER_ID>{ $CustomerID }</ns0:CUSTOMER_ID>
            <ns0:TYPE>{ $TypeSearch }</ns0:TYPE>
            <ns0:LIABILITY_TYPE>{ $LiabilitySearch }</ns0:LIABILITY_TYPE>
            <ns0:ASSET_TYPE>{ $AssetSearch }</ns0:ASSET_TYPE>
            
          
        </ns0:sjConsultaActivosPasivosCliente>
};

declare variable $requestHeaderIN as element(ns1:RequestHeader) external;
declare variable $CustomerID as xs:string external;
declare variable $TypeSearch as xs:string external;
declare variable $AssetSearch as xs:string external;
declare variable $LiabilitySearch as xs:string external;


xf:consultaPasivosActivosIN($requestHeaderIN,
    $CustomerID,
    $TypeSearch,
    $AssetSearch,
    $LiabilitySearch )
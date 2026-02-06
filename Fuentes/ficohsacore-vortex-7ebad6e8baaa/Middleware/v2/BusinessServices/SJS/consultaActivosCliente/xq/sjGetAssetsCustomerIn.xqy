xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosClienteRequest" element="ns0:sjConsultaActivosClienteRequest" location="../../../../../Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaActivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../ConsultaFondoPensiones12c/xsd/GetAssetsCustomerTypes.xsd" ::)

declare namespace ns2 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns1 = "https://www.ficohsa.com/regional/pension";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaActivosCliente/xq/sjGetAssetsCustomerIn/";

declare function xf:sjGetAssetsCustomerIn($sjConsultaActivosClienteRequest as element(ns0:sjConsultaActivosClienteRequest),
    $sourceBank as xs:string,
    $destinationBank as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <GeneralInfo>
                <SourceBank>{ $sourceBank }</SourceBank>
                <DestinationBank>{ $destinationBank }</DestinationBank>
                <ApplicationUser>{ data($sjConsultaActivosClienteRequest/ns0:USERNAME) }</ApplicationUser>
                <Language>es</Language>
            </GeneralInfo>
            <PV_IDENTIFICATION_TYPE>{ data($sjConsultaActivosClienteRequest/ns0:LEGAL_ID_TYPE) }</PV_IDENTIFICATION_TYPE>
            <PV_IDENTIFICACION>{ data($sjConsultaActivosClienteRequest/ns0:LEGAL_ID) }</PV_IDENTIFICACION>
        </ns1:InputParameters>
};

declare variable $sjConsultaActivosClienteRequest as element(ns0:sjConsultaActivosClienteRequest) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;

xf:sjGetAssetsCustomerIn($sjConsultaActivosClienteRequest,
    $sourceBank,
    $destinationBank)
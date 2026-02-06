xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse" element="ns1:ConsultadeclienteResponse" location="../../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../FPC/consultaSituacionFinanciera12c/xsd/GetFinancialSituationTypes.xsd" ::)

declare namespace ns2 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "https://www.ficohsa.com/regional/pension";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/getFinancialSituationIn/";

declare function obtenerXMLDocumentos()
    as element(*){
    	<LEGAL_ID_TYPES>
			<LEGAL_ID_TYPE name="CEDULA">CC</LEGAL_ID_TYPE>
			<LEGAL_ID_TYPE name="NIT" >NIT</LEGAL_ID_TYPE>
			<LEGAL_ID_TYPE name="PASAPORTE" >PAS</LEGAL_ID_TYPE>
			<LEGAL_ID_TYPE name="CARNET DE RESIDENTE">CAR</LEGAL_ID_TYPE>
		</LEGAL_ID_TYPES>
    };
declare function xf:convertirTipoDocumento($tipoDocumento as xs:string)
    as xs:string {
        let $codEquivalente := string(obtenerXMLDocumentos()/LEGAL_ID_TYPE[ @name=$tipoDocumento ]/text())
				return
					if($codEquivalente != '')then(
						$codEquivalente
					)else(
						$tipoDocumento
					)
};

declare function xf:getFinancialSituationIn($consultadeclienteResponse as element(ns1:ConsultadeclienteResponse),
    $requestHeader as element(ns3:RequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <GeneralInfo>
                <SourceBank>{ data($requestHeader/Region/SourceBank) }</SourceBank>
                {
                    for $DestinationBank in $requestHeader/Region/DestinationBank
                    return
                        <DestinationBank>{ data($DestinationBank) }</DestinationBank>
                }
                <ApplicationUser>{ data($requestHeader/Authentication/UserName) }</ApplicationUser>
                <Language>es</Language>
            </GeneralInfo>
            {
            	for $LEGALDOCNAME in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALDOCNAME
            	return
            	<PV_IDENTIFICATION_TYPE>{ xf:convertirTipoDocumento(fn:data($LEGALDOCNAME)) }</PV_IDENTIFICATION_TYPE>
            }
            <PV_BANCO_ORIGEN>{ data($requestHeader/Region/SourceBank) }</PV_BANCO_ORIGEN>
            <PT_NUMERO_IDENTIFICACION>
                {
                    for $LEGALID in $consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALID
                    return
                        <PT_NUMERO_IDENTIFICACION_ITEM>{ data($LEGALID) }</PT_NUMERO_IDENTIFICACION_ITEM>
                }
            </PT_NUMERO_IDENTIFICACION>
        </ns0:InputParameters>
};

declare variable $consultadeclienteResponse as element(ns1:ConsultadeclienteResponse) external;
declare variable $requestHeader as element(ns3:RequestHeader) external;

xf:getFinancialSituationIn($consultadeclienteResponse,
    $requestHeader)
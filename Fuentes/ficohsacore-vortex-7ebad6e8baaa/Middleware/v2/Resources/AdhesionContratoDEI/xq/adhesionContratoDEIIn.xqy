xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$adhesionContratoRequest" element="ns0:adhesionContratoRequest" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/adhesionContrato/xsd/adhesionContrato_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/adhesionContrato";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AdhesionContrato/xq/adhesionContratoDEIIn/";

declare function xf:adhesionContratoDEIIn($adhesionContratoRequest as element(ns0:adhesionContratoRequest),
    $requestHeader as element(ns2:RequestHeader))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	{
        		let $tipoPersona := fn:string($adhesionContratoRequest/TYPE_TAXPAYER/text())
        		return
        			if($tipoPersona = 'N') then(
        				<ns1:PN_TIPOCONTRIB>1</ns1:PN_TIPOCONTRIB>
        			) else(
        				<ns1:PN_TIPOCONTRIB>2</ns1:PN_TIPOCONTRIB>
        			)
        	}            
            <ns1:PT_AUDITORIAINFO>
                <ns1:RTN>{ data($adhesionContratoRequest/RTN) }</ns1:RTN>
                <ns1:USUARIO_SERVICIO>{ data($requestHeader/Authentication/UserName) }</ns1:USUARIO_SERVICIO>
                <ns1:PROCESO_ORIGEN_ERROR>TributosDEI.adhesionContrato</ns1:PROCESO_ORIGEN_ERROR>
            </ns1:PT_AUDITORIAINFO>
            <ns1:PV_EMAIL>{ data($adhesionContratoRequest/EMAIL) }</ns1:PV_EMAIL>
            <ns1:PD_FECHACONST>{ data($adhesionContratoRequest/BUILDING_DATE) }</ns1:PD_FECHACONST>
            <ns1:PV_RAZONSOCIAL>{ data($adhesionContratoRequest/BUSINESS_NAME) }</ns1:PV_RAZONSOCIAL>
            <ns1:PV_IDREPLEGAL>{ data($adhesionContratoRequest/LEGAL_REP_ID) }</ns1:PV_IDREPLEGAL>
            <ns1:PV_NOMBREREPLEGAL>{ data($adhesionContratoRequest/LEGAL_REP_NAME) }</ns1:PV_NOMBREREPLEGAL>
            <ns1:PV_NUMEROESCRITURA>{ data($adhesionContratoRequest/DEED_NUMBER) }</ns1:PV_NUMEROESCRITURA>
            <ns1:PD_FECHAESCRITURA>{ data($adhesionContratoRequest/DEED_DATE) }</ns1:PD_FECHAESCRITURA>
            <ns1:PV_DJULTIMONUMERO>{ data($adhesionContratoRequest/DJ_LAST_NUMBER) }</ns1:PV_DJULTIMONUMERO>
            <ns1:PD_DJULTIMAFECHA>{ data($adhesionContratoRequest/DJ_LAST_DATE) }</ns1:PD_DJULTIMAFECHA>
            <ns1:PD_FECHANACIMIENTO>{ data($adhesionContratoRequest/BIRTH_DATE) }</ns1:PD_FECHANACIMIENTO>
            <ns1:PV_PRIMERNOMBRE>{ data($adhesionContratoRequest/FIRST_NAME) }</ns1:PV_PRIMERNOMBRE>
            {
                for $MIDDLE_NAME in $adhesionContratoRequest/MIDDLE_NAME
                return
                    <ns1:PV_SEGUNDONOMBRE>{ data($MIDDLE_NAME) }</ns1:PV_SEGUNDONOMBRE>
            }
            <ns1:PV_PRIMERAPELLIDO>{ data($adhesionContratoRequest/FIRST_SURNAME) }</ns1:PV_PRIMERAPELLIDO>
            {
                for $SECOND_SURNAME in $adhesionContratoRequest/SECOND_SURNAME
                return
                    <ns1:PV_SEGUNDOAPELLIDO>{ data($SECOND_SURNAME) }</ns1:PV_SEGUNDOAPELLIDO>
            }
        </ns1:InputParameters>
};

declare variable $adhesionContratoRequest as element(ns0:adhesionContratoRequest) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:adhesionContratoDEIIn($adhesionContratoRequest,
    $requestHeader)
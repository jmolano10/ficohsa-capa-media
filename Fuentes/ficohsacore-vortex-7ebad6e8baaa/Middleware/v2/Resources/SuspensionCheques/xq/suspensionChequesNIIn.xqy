xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$suspensionChequesRequest" element="ns1:suspensionChequesRequest" location="../xsd/suspensionChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opSuspensionChequesSolicitud" location="../../../BusinessServices/CTS/cheques/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobischeques.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/suspensionChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuspensionCheques/xq/suspensionChequesNIIn/";

declare function motivoParoDePago ($item as item()) as xs:string {
	if (upper-case(fn:string($item/text())) = 'LOST' ) then (
		'P'
	) else if (upper-case(fn:string($item/text())) = 'STOLEN' ) then(
		"R"
	)else('')
};

declare function xf:suspensionChequesNIIn($suspensionChequesRequest as element(ns1:suspensionChequesRequest))
    as element(ns2:opSuspensionChequesSolicitud) {
        <ns2:opSuspensionChequesSolicitud>
            <ns0:contextoTransaccional>
               		<ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cuenta>
	                <ns0:codCuentaHabiente>{ data($suspensionChequesRequest/ACCOUNT_NUMBER) }</ns0:codCuentaHabiente>
            </ns0:cuenta>
            <ns0:chequera>
	                <ns0:numeroChequeInicio>{ data($suspensionChequesRequest/FIRST_CHEQUE_NUMBER) }</ns0:numeroChequeInicio>
	                <ns0:numeroChequeFin>{ data($suspensionChequesRequest/LAST_CHEQUE_NUMBER) }</ns0:numeroChequeFin>
            </ns0:chequera>
           		    <ns0:motivoParoDePago>{motivoParoDePago($suspensionChequesRequest/PAYMENT_STOP_MOTIVE)}</ns0:motivoParoDePago>
        </ns2:opSuspensionChequesSolicitud>
};

declare variable $suspensionChequesRequest as element(ns1:suspensionChequesRequest) external;

xf:suspensionChequesNIIn($suspensionChequesRequest)
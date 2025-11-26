(:: pragma bea:global-element-parameter parameter="$solicituddechequera_ValidateResponse" element="ns0:Solicituddechequera_ValidateResponse" location="../Resources/XMLSchema_21306858.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMontoTipoChequeraResponse" location="consultaMontoTipoChequeraTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTipoChequeraTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/solicitudChequeras/consultaMontoTipoChequera/consultaMontoTipoChequeraOut/";

declare function xf:consultaMontoTipoChequeraOut($solicituddechequera_ValidateResponse as element(ns0:Solicituddechequera_ValidateResponse))
    as element(ns1:consultaMontoTipoChequeraResponse) {
        <ns1:consultaMontoTipoChequeraResponse>
        {
        	if ($solicituddechequera_ValidateResponse/Status/successIndicator/text() = "Success") then (
        		<CHARGE_CURRENCY>{ data($solicituddechequera_ValidateResponse/FICOHCHECKBOOKREQUESTType/CURRENCY) }</CHARGE_CURRENCY>,
        		<CHARGE_AMOUNT>{ data($solicituddechequera_ValidateResponse/FICOHCHECKBOOKREQUESTType/CHEQUECHARGE) }</CHARGE_AMOUNT>
        	) else ()
        }
        </ns1:consultaMontoTipoChequeraResponse>
};

declare variable $solicituddechequera_ValidateResponse as element(ns0:Solicituddechequera_ValidateResponse) external;

xf:consultaMontoTipoChequeraOut($solicituddechequera_ValidateResponse)
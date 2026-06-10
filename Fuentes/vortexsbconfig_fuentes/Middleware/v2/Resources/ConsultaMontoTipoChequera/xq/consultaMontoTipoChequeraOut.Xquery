<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$solicituddechequera_ValidateResponse" element="ns0:Solicituddechequera_ValidateResponse" location="../../../../Business_Resources/solicitudChequeras/Resources/XMLSchema_21306858.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMontoTipoChequeraResponse" location="../xsd/consultaMontoTipoChequeraTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMontoTipoChequera/xq/consultaMontoTipoChequeraOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTipoChequeraTypes";
declare namespace ns0 = "T24WebServicesImpl";

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

xf:consultaMontoTipoChequeraOut($solicituddechequera_ValidateResponse)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/solicitudChequeras/Resources/XMLSchema_21306858.xsd">
        <con:schema ref="Middleware/Business_Resources/solicitudChequeras/Resources/XMLSchema_21306858"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaMontoTipoChequeraTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaMontoTipoChequera/xsd/consultaMontoTipoChequeraTypes"/>
    </con:dependency>
</con:xqueryEntry>
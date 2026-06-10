<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCuentaAperturadaResponse" element="ns0:ConsultaCuentaAperturadaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSolicitudAperturaCuentaResponse" location="../xsd/consultaSolicitudAperturaCuentaTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSolicitudAperturaCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSolicitudAperturaCuenta/xq/consultaSolicitudAperturaCuentaOut/";

declare function xf:consultaSolicitudAperturaCuentaOut($consultaCuentaAperturadaResponse as element(ns0:ConsultaCuentaAperturadaResponse))
    as element(ns1:consultaSolicitudAperturaCuentaResponse) {
        <ns1:consultaSolicitudAperturaCuentaResponse>
            {
                for $CODID in $consultaCuentaAperturadaResponse/FICOBULKAPPACCTWSType[1]/gFICOBULKAPPACCTWSDetailType/mFICOBULKAPPACCTWSDetailType[1]/CODID
                return
                    <COD_ID>{ data($CODID) }</COD_ID>
            }
            {
                for $IDTABLE in $consultaCuentaAperturadaResponse/FICOBULKAPPACCTWSType[1]/gFICOBULKAPPACCTWSDetailType/mFICOBULKAPPACCTWSDetailType[1]/IDTABLE
                return
                    <ID_TABLE>{ data($IDTABLE) }</ID_TABLE>
            }
            {
                for $ESTADO in $consultaCuentaAperturadaResponse/FICOBULKAPPACCTWSType[1]/gFICOBULKAPPACCTWSDetailType/mFICOBULKAPPACCTWSDetailType[1]/ESTADO
                return
                    <ESTADO>{ data($ESTADO) }</ESTADO>
            }
            {
                for $DESCRECHAZO in $consultaCuentaAperturadaResponse/FICOBULKAPPACCTWSType[1]/gFICOBULKAPPACCTWSDetailType/mFICOBULKAPPACCTWSDetailType[1]/DESCRECHAZO
                return
                    <DESC_RECHAZO>{ data($DESCRECHAZO) }</DESC_RECHAZO>
            }
        </ns1:consultaSolicitudAperturaCuentaResponse>
};

declare variable $consultaCuentaAperturadaResponse as element(ns0:ConsultaCuentaAperturadaResponse) external;

xf:consultaSolicitudAperturaCuentaOut($consultaCuentaAperturadaResponse)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaSolicitudAperturaCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSolicitudAperturaCuenta/xsd/consultaSolicitudAperturaCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>
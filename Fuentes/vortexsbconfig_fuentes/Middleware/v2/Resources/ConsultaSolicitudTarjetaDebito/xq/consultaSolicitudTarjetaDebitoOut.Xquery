<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTDNuevaResponse" element="ns0:ConsultaTDNuevaResponse" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSolicitudTarjetaDebitoResponse" location="../xsd/consultaSolicitudTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSolicitudTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSolicitudTarjetaDebito/xq/consultaSolicitudTarjetaDebitoOut/";

declare function xf:consultaSolicitudTarjetaDebitoOut($consultaTDNuevaResponse as element(ns0:ConsultaTDNuevaResponse))
    as element(ns1:consultaSolicitudTarjetaDebitoResponse) {
        <ns1:consultaSolicitudTarjetaDebitoResponse>
            {
                for $CODID in $consultaTDNuevaResponse/FICOBULKAPPTDWSType[1]/gFICOBULKAPPTDWSDetailType/mFICOBULKAPPTDWSDetailType[1]/CODID
                return
                    <COD_ID>{ data($CODID) }</COD_ID>
            }
            {
                for $IDTABLE in $consultaTDNuevaResponse/FICOBULKAPPTDWSType[1]/gFICOBULKAPPTDWSDetailType/mFICOBULKAPPTDWSDetailType[1]/IDTABLE
                return
                    <ID_TABLE>{ data($IDTABLE) }</ID_TABLE>
            }
            {
                for $ESTADO in $consultaTDNuevaResponse/FICOBULKAPPTDWSType[1]/gFICOBULKAPPTDWSDetailType/mFICOBULKAPPTDWSDetailType[1]/ESTADO
                return
                    <ESTADO>{ data($ESTADO) }</ESTADO>
            }
        </ns1:consultaSolicitudTarjetaDebitoResponse>
};

declare variable $consultaTDNuevaResponse as element(ns0:ConsultaTDNuevaResponse) external;

xf:consultaSolicitudTarjetaDebitoOut($consultaTDNuevaResponse)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaSolicitudTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSolicitudTarjetaDebito/xsd/consultaSolicitudTarjetaDebitoTypes"/>
    </con:dependency>
</con:xqueryEntry>
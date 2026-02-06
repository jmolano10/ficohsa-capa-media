xquery version "2004-draft";
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

xf:consultaSolicitudTarjetaDebitoOut($consultaTDNuevaResponse)
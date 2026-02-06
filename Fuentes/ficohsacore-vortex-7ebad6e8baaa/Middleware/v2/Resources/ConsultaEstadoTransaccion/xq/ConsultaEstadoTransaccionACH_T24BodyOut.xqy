xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccionACHResponse1" element="ns0:ConsultaEstadoTransaccionACHResponse" location="../../../BusinessServices/T24/ConsultaEstadoTransaccionACH/xsd/ConsultaEstadoTransaccionACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoTransaccionResponse" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/ConsultaEstadoTransaccionACH_T24BodyOut/";

declare function xf:ConsultaEstadoTransaccionACH_T24BodyOut($consultaEstadoTransaccionACHResponse1 as element(ns0:ConsultaEstadoTransaccionACHResponse))
    as element(ns1:consultaEstadoTransaccionResponse) {
        <ns1:consultaEstadoTransaccionResponse>
            {
                for $IDTRNT24 in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/IDTRNT24
                return
                    <ID_TRN>{ data($IDTRNT24) }</ID_TRN>
            }
        </ns1:consultaEstadoTransaccionResponse>
};

declare variable $consultaEstadoTransaccionACHResponse1 as element(ns0:ConsultaEstadoTransaccionACHResponse) external;

xf:ConsultaEstadoTransaccionACH_T24BodyOut($consultaEstadoTransaccionACHResponse1)
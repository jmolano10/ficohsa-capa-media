(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns1:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registraDespignoracionOPI" location="../../RegistraDespignoracionOPI/xsd/registraDespignoracionesOPITypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reistraDespignoracionOPITypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/registraDespignoracionOpiIn/";

declare function xf:registraDespignoracionOpiIn($procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24))
    as element(ns0:registraDespignoracionOPI) {
        <ns0:registraDespignoracionOPI>
             {
        let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        return
        (
            <ACCOUNT_NUMBER>{$messageListFM[1]}</ACCOUNT_NUMBER>,
            <DESCRIPTION>{$messageListFM[2]}</DESCRIPTION>,
            <VALUE>{$messageListFM[3]}</VALUE>,
            <STATE>{$messageListFM[4]}</STATE>,
            <ID_REFERENCE_T24>{$messageListFM[5]}</ID_REFERENCE_T24>,
            <NUM_MODIFICATIONS>{$messageListFM[6]}</NUM_MODIFICATIONS>,
            <REALESE_DATE>{fn-bea:dateTime-from-string-with-format('yyyyMMdd',$messageListFM[7])}</REALESE_DATE>,
            <CORE_DATE>{fn-bea:dateTime-from-string-with-format('yyyyMMdd',$messageListFM[8])}</CORE_DATE>
            )
            }
        </ns0:registraDespignoracionOPI>
};

declare variable $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24) external;

xf:registraDespignoracionOpiIn($procesaMensajeGenericoT24)
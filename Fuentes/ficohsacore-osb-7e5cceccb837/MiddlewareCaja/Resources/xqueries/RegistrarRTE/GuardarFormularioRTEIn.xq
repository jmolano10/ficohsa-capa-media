(:: pragma bea:global-element-parameter parameter="$registrarRTE" element="ns0:registrarRTE" location="../../xsds/RegistrarRTE/RegistrarRTE.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registrodeRTEResponse" element="ns1:RegistrodeRTEResponse" location="../../xsds/RegistroRTE/XMLSchema_-102414330.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../xsds/RegistrarRTE/GuardarFormularioRTE/FLINK_OSB_GUARDAR_FORMULARIO_RTE.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_GUARDAR_FORMULARIO_RTE/";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/GuardarFormularioRTEIn/";

declare function xf:GuardarFormularioRTEIn($registrarRTE as element(ns0:registrarRTE),
    $registrodeRTEResponse as element(ns1:RegistrodeRTEResponse))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:SECUENCIAL>{ data($registrarRTE/TELLER_TRANS_ID) }</ns2:SECUENCIAL>
            {
                for $transactionId in $registrodeRTEResponse/Status/transactionId
                return
                    <ns2:FORMULARIO_RTE>{ data($transactionId) }</ns2:FORMULARIO_RTE>
            }
        </ns2:InputParameters>
};

declare variable $registrarRTE as element(ns0:registrarRTE) external;
declare variable $registrodeRTEResponse as element(ns1:RegistrodeRTEResponse) external;

xf:GuardarFormularioRTEIn($registrarRTE,
    $registrodeRTEResponse)
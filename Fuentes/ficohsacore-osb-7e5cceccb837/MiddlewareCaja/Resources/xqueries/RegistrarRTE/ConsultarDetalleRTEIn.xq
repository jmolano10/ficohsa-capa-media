(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../xsds/RegistrarRTE/ConsultarFormularioRTE/FLINK_OSB_CONSULTAR_FORMULARIO_RTE.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadedetalleRTE" location="../../xsds/RegistroRTE/XMLSchema_-102414330.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_FORMULARIO_RTE/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/ConsultarDetalleRTEIn/";

declare function xf:ConsultarDetalleRTEIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:ConsultadedetalleRTE) {
        <ns0:ConsultadedetalleRTE>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSFICORTEENQType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    {
                        for $FORMULARIO_RTE in $outputParameters/ns1:FORMULARIO_RTE
                        return
                            <criteriaValue>{ data($FORMULARIO_RTE) }</criteriaValue>
                    }
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICORTEENQType>
        </ns0:ConsultadedetalleRTE>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultarDetalleRTEIn($autenticacionRequestHeader,
    $outputParameters)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MDW/listadoErroresResiliencia/xsd/listadoErroresResiliencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:listadoErroresResilienciaResponse" location="../wsdl/listadoErroresResilienciaPS.wsdl" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoErroresResiliencia";
declare namespace ns1 = "http://www.example.org/listadoErroresResilienciaPS/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListadoErroresResiliencia/xq/listadoErroresResilienciaOut/";

declare function xf:listadoErroresResilienciaOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:listadoErroresResilienciaResponse) {
        <ns1:listadoErroresResilienciaResponse>
            {
                for $MENSAJES_ERRORES in $outputParameters/ns0:MENSAJES_ERRORES
                return
                    <MENSAJES_ERRORES>
                        {
                            for $MENSAJE_ERROR in $MENSAJES_ERRORES/ns0:MENSAJE_ERROR
                            return
                                <MENSAJE_ERROR>{ data($MENSAJE_ERROR) }</MENSAJE_ERROR>
                        }
                    </MENSAJES_ERRORES>
            }
            {
                for $CODIGO_ERROR in $outputParameters/ns0:CODIGO_ERROR
                return
                    <CODIGO_ERROR>{ data($CODIGO_ERROR) }</CODIGO_ERROR>
            }
            {
                for $DESCRIPCION_ERROR in $outputParameters/ns0:DESCRIPCION_ERROR
                return
                    <DESCRIPCION_ERROR>{ data($DESCRIPCION_ERROR) }</DESCRIPCION_ERROR>
            }
        </ns1:listadoErroresResilienciaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:listadoErroresResilienciaOut($outputParameters)
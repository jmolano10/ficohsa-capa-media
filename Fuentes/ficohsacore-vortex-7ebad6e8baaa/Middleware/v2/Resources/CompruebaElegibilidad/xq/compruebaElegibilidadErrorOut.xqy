xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/CompruebaElegibilidad/xsd/compruebaElegibilidad_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:compruebaElegibilidadResponse" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/compruebaElegibilidad";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompruebaElegibilidad/xq/compruebaElegibilidadOut/";

declare function xf:compruebaElegibilidadOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:compruebaElegibilidadResponse) {
        <ns0:compruebaElegibilidadResponse>
            {
                for $PV_REQUESTIDOUT in $outputParameters/ns1:PV_REQUESTIDOUT
                return
                	if( $PV_REQUESTIDOUT/text() != "" )then (
                    	<REQUEST_ID>{ data($PV_REQUESTIDOUT) }</REQUEST_ID>
                	 )else()
            }
            {
                for $PV_PROCESSIDOUT in $outputParameters/ns1:PV_PROCESSIDOUT
                return
                	if( $PV_PROCESSIDOUT/text() != "" )then (
                    	<PROCESS_ID>{ data($PV_PROCESSIDOUT) }</PROCESS_ID>
                	)else()
            }
            {
                for $PV_RETURNCODE in $outputParameters/ns1:PV_RETURNCODE
                return
                	if( $PV_RETURNCODE/text() != "" )then (
                    	<RETURN_CODE>{ data($PV_RETURNCODE) }</RETURN_CODE>
                	)else()
            }
            {
                for $PV_ERRORDESCRIPTION in $outputParameters/ns1:PV_ERRORDESCRIPTION
                return
                	if( $PV_ERRORDESCRIPTION/text() != "" )then (
                    	<ERROR_DESCRIPTION>{ data($PV_ERRORDESCRIPTION) }</ERROR_DESCRIPTION>
                    )else()
            }                                                                   
        </ns0:compruebaElegibilidadResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:compruebaElegibilidadOut($outputParameters)
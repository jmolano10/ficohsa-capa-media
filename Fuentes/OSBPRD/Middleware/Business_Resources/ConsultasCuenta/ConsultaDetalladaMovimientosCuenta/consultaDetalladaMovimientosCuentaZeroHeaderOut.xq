(:: pragma bea:global-element-parameter parameter="$consultadetalladademovscuentaResponse" element="ns0:ConsultadetalladademovscuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuenta/consultaDetalladaMovimientosCuentaZeroHeaderOut/";

declare function xf:consultaDetalladaMovimientosCuentaZeroHeaderOut($consultadetalladademovscuentaResponse as element(ns0:ConsultadetalladademovscuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	<successIndicator>NO RECORDS</successIndicator>
            {
                for $ZERORECORDS in $consultadetalladademovscuentaResponse/WSFICOSTMTBOOKDETAILType[1]/ZERORECORDS
                return
                    <messages>{ data($ZERORECORDS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetalladademovscuentaResponse as element(ns0:ConsultadetalladademovscuentaResponse) external;

xf:consultaDetalladaMovimientosCuentaZeroHeaderOut($consultadetalladademovscuentaResponse)
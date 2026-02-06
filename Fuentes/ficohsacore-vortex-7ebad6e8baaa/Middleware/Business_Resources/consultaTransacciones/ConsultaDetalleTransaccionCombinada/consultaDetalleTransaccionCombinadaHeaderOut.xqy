xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTFSResponse1" element="ns0:ConsultadetransaccionTFSResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleTransaccionCombinada/consultaDetalleTransaccionCombinadaHeaderOut/";

declare function xf:consultaDetalleTransaccionCombinadaHeaderOut($consultadetransaccionTFSResponse1 as element(ns0:ConsultadetransaccionTFSResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadetransaccionTFSResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadetransaccionTFSResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetransaccionTFSResponse1 as element(ns0:ConsultadetransaccionTFSResponse) external;

xf:consultaDetalleTransaccionCombinadaHeaderOut($consultadetransaccionTFSResponse1)
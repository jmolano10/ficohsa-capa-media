xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetsobregiroufranticipoResponse1" element="ns0:ConsultadetsobregiroufranticipoResponse" location="Resources/XMLSchema_865025152.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetallePD/ConsultaDetallePDZeroHeaderOut/";

declare function xf:ConsultaDetallePDZeroHeaderOut($consultadetsobregiroufranticipoResponse1 as element(ns0:ConsultadetsobregiroufranticipoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadetsobregiroufranticipoResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            <successIndicator>NO RECORDS</successIndicator>
            {
                for $ZERORECORDS in $consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/ZERORECORDS
                return
                    <messages>{ data($ZERORECORDS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetsobregiroufranticipoResponse1 as element(ns0:ConsultadetsobregiroufranticipoResponse) external;

xf:ConsultaDetallePDZeroHeaderOut($consultadetsobregiroufranticipoResponse1)
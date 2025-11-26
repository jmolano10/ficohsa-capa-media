(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTFSResponse" element="ns0:ConsultadetransaccionTFSResponse" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaReciboTransaccionRTEResponse" location="../../xsds/ConsultaReciboTransaccionRTE/ConsultaReciboTransaccionRTE.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaReciboTransaccionRTETypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboTransaccionRTE/ConsultaDetalleTransaccionTFSOut/";

declare function xf:ConsultaDetalleTransaccionTFSOut($consultadetransaccionTFSResponse as element(ns0:ConsultadetransaccionTFSResponse))
    as element(ns1:consultaReciboTransaccionRTEResponse) {
        <ns1:consultaReciboTransaccionRTEResponse>
            {
                for $ID in $consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/ID
                return
                    <TRANSACTION_ID>{ data($ID) }</TRANSACTION_ID>
            }
            {
                for $TXNDESC in $consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/TXNDESC
                return
                    <TRANSACTION_NAME>{ data($TXNDESC) }</TRANSACTION_NAME>
            }            
            {
                for $DATETIME in $consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/DATETIME
                return
                    <DATE_TIME>{ concat("20", $DATETIME) }</DATE_TIME>
            }
            {
                for $TXNCURRENCY in fn:tokenize($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/TXNCURRENCY, "\|\|")[1]
                return
                    <CURRENCY>{ data($TXNCURRENCY) }</CURRENCY>
            }
            {
                for $TXNAMOUNT in $consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/gWSTFSTRANSACTIONDetailType/mWSTFSTRANSACTIONDetailType[1]/TXNAMOUNT
                return
                    <AMOUNT>{ data($TXNAMOUNT) }</AMOUNT>
            }
        </ns1:consultaReciboTransaccionRTEResponse>
};

declare variable $consultadetransaccionTFSResponse as element(ns0:ConsultadetransaccionTFSResponse) external;

xf:ConsultaDetalleTransaccionTFSOut($consultadetransaccionTFSResponse)
xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns0:procesaMensajeGenericoT24" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:reversaVentaMenor" location="../../ReversaVentaMenor/xsd/reversaVentaMenorTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaVentaMenorFacade/xq/registraVentaMenoFacadeIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversaVentaMenorTypes";

declare function xf:registraVentaMenoFacadeIn($procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:reversaVentaMenor) {
        <ns1:reversaVentaMenor>
       {
       		let $messageListFM := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM")
        	return(
	        	<REVERSION_ID>{$messageListFM[2]}</REVERSION_ID>,
	        	<TRANSACTION_DATE>{$messageListFM[6]}</TRANSACTION_DATE>,
	        	<TRANSACTION_ID>{$messageListFM[11]}</TRANSACTION_ID>,
	        	<USER_ID>{$messageListFM[9]}</USER_ID>,
	        	<BRANCH>{$messageListFM[10]}</BRANCH>
        	)
       }
        </ns1:reversaVentaMenor>
};

declare variable $procesaMensajeGenericoT24 as element(ns0:procesaMensajeGenericoT24) external;

xf:registraVentaMenoFacadeIn($procesaMensajeGenericoT24)
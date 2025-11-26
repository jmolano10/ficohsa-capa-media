(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaTDCporClienteHeaderOut2/";

declare function xf:consultaTDCporClienteHeaderOut2($MessageID as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
            if  (fn:string($MessageID) = '97' ) then
        	(
            	<successIndicator>{'NO RECORDS'}</successIndicator>
            )
            else if (fn:string($MessageID) = '96' )  then
            (
            	<successIndicator>{'ERROR'}</successIndicator>
            )
             else if (fn:string($MessageID) = '00' )  then
              (
               <successIndicator>{'SUCCESS'}</successIndicator>
            )
            else
            ()
            
            }
            
            {
            if (fn:string($MessageID) = '97' )  then
        	(
            	<messages>{ concat('@SM@FM','NORECORDS') }</messages>
            )
            else if (fn:string($MessageID) = '96' ) then
            (
            	<messages>{ concat('@SM@FM','ERROR') }</messages>
            )
            else
            ()
           }
        </ns0:ResponseHeader>
};

declare variable $MessageID as xs:string external;
xf:consultaTDCporClienteHeaderOut2($MessageID)

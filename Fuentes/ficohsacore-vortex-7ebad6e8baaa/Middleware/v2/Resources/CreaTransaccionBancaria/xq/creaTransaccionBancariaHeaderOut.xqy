xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creatransaccionACHResponse1" element="ns0:CreatransaccionACHResponse" location="../../../BusinessServices/T24/CreaTransaccionBancariaACH/xsd/creaTransaccionBancariaACH.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionBancariaHeaderOut/";

declare function xf:creaTransaccionBancariaHeaderOut($creatransaccionACHResponse1 as element(ns0:CreatransaccionACHResponse))
    as element(ns1:ResponseHeader) {
    
		if (fn:upper-case(data($creatransaccionACHResponse1/Status/successIndicator)) = 'SUCCESS')then 
		    (
				if (fn:upper-case(data($creatransaccionACHResponse1/FICOHNACHONLINEType/STATUS)) = 'SUCCESS')then 
				(     
				<ns1:ResponseHeader>
				    {
				        for $transactionId in $creatransaccionACHResponse1/Status/transactionId
				        return
				            <transactionId>{ data($transactionId) }</transactionId>
				    }
				    {
				        for $messageId in $creatransaccionACHResponse1/Status/messageId
				        return
				            <messageId>{ data($messageId) }</messageId>
				    }
				    {
				        for $successIndicator in $creatransaccionACHResponse1/Status/successIndicator
				        return
				            <successIndicator>{ 'SUCCESS'  }</successIndicator>
				    }
				    {
				        for $application in $creatransaccionACHResponse1/Status/application
				        return
				            <application>{ data($application) }</application>
				    }
				    {
				        for $messages in $creatransaccionACHResponse1/Status/messages
				        return
				            <messages>{ data($messages) }</messages>
				    }				    
				</ns1:ResponseHeader>
       			)
		        else
		        (
		        <ns1:ResponseHeader>
				    {
				        for $transactionId in $creatransaccionACHResponse1/Status/transactionId
				        return
				            <transactionId>{ data($transactionId) }</transactionId>
				    }
				    {
				        for $messageId in $creatransaccionACHResponse1/Status/messageId
				        return
				            <messageId>{ data($messageId) }</messageId>
				    }
				    {
				        for $successIndicator in $creatransaccionACHResponse1/Status/successIndicator
				        return
				            <successIndicator>{ 'ERROR' }</successIndicator>
				    }
				    {
				        for $application in $creatransaccionACHResponse1/Status/application
				        return
				            <application>{ data($application) }</application>
				    }
				    {
				        for $IDREJECTION in $creatransaccionACHResponse1/FICOHNACHONLINEType/IDREJECTION
				        return
				            <messages>{ data($IDREJECTION) }</messages>
				    }				   
				</ns1:ResponseHeader>
		        )
		        )
        else if (fn:upper-case(data($creatransaccionACHResponse1/Status/successIndicator)) = 'T24ERROR')then 
        (
        <ns1:ResponseHeader>
		    {
		        for $transactionId in $creatransaccionACHResponse1/Status/transactionId
		        return
		            <transactionId>{ data($transactionId) }</transactionId>
		    }
		    {
		        for $messageId in $creatransaccionACHResponse1/Status/messageId
		        return
		            <messageId>{ data($messageId) }</messageId>
		    }
		    {
		        for $successIndicator in $creatransaccionACHResponse1/Status/successIndicator
		        return
		            <successIndicator>{ 'ERROR'   }</successIndicator>
		    }
		    {
		        for $application in $creatransaccionACHResponse1/Status/application
		        return
		            <application>{ data($application) }</application>
		    }
		    {
		        for $messages in $creatransaccionACHResponse1/Status/messages
		        return
		            <messages>{ data($messages) }</messages>
		    }		    
		</ns1:ResponseHeader>
        )
        else if (fn:upper-case(data($creatransaccionACHResponse1/Status/successIndicator)) = 'TWSERROR')then 
        (
        <ns1:ResponseHeader>
		    {
		        for $transactionId in $creatransaccionACHResponse1/Status/transactionId
		        return
		            <transactionId>{ data($transactionId) }</transactionId>
		    }
		    {
		        for $messageId in $creatransaccionACHResponse1/Status/messageId
		        return
		            <messageId>{ data($messageId) }</messageId>
		    }
		    {
		        for $successIndicator in $creatransaccionACHResponse1/Status/successIndicator
		        return
		            <successIndicator>{ 'PENDING'   }</successIndicator>
		    }
		    {
		        for $application in $creatransaccionACHResponse1/Status/application
		        return
		            <application>{ data($application) }</application>
		    }
		    {
		        for $messages in $creatransaccionACHResponse1/Status/messages
		        return
		            <messages>{ data($messages) }</messages>
		    }		    
		</ns1:ResponseHeader>
        )
        else
        (
        <ns1:ResponseHeader>
		    {
		        for $transactionId in $creatransaccionACHResponse1/Status/transactionId
		        return
		            <transactionId>{ data($transactionId) }</transactionId>
		    }
		    {
		        for $messageId in $creatransaccionACHResponse1/Status/messageId
		        return
		            <messageId>{ data($messageId) }</messageId>
		    }
		    {
		        for $successIndicator in $creatransaccionACHResponse1/Status/successIndicator
		        return
		            <successIndicator>{ 'ERROR'   }</successIndicator>
		    }
		    {
		        for $application in $creatransaccionACHResponse1/Status/application
		        return
		            <application>{ data($application) }</application>
		    }
		    {
		        for $messages in $creatransaccionACHResponse1/Status/messages
		        return
		            <messages>{ data($messages) }</messages>
		    }		    
		</ns1:ResponseHeader>
        )
};

declare variable $creatransaccionACHResponse1 as element(ns0:CreatransaccionACHResponse) external;

xf:creaTransaccionBancariaHeaderOut($creatransaccionACHResponse1)
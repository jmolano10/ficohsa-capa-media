xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoTransaccionACHResponse1" element="ns0:ConsultaEstadoTransaccionACHResponse" location="../../../BusinessServices/T24/ConsultaEstadoTransaccionACH/xsd/ConsultaEstadoTransaccionACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccion/xq/ConsultaEstadoTransaccionACH_T24Out/";

declare function xf:ConsultaEstadoTransaccionACH_T24Out($consultaEstadoTransaccionACHResponse1 as element(ns0:ConsultaEstadoTransaccionACHResponse))
    as element(ns1:ResponseHeader) {
    if (fn:upper-case(data($consultaEstadoTransaccionACHResponse1/Status/successIndicator)) = 'SUCCESS')then( 
	         for $STATUS in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/STATUS
	             return(
	             if (fn:upper-case(data($STATUS)) = 'SUCCESS' or fn:upper-case(data($STATUS)) = 'REVERSED' )then(                              
					<ns1:ResponseHeader>            
					    {
					        for $STATUS in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/STATUS
					        return
					            <successIndicator>{ 'SUCCESS' }</successIndicator>
					    }
					    {
					        for $IDREJECTION in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/IDREJECTION
					        return
					            <messages>{ data($IDREJECTION) }</messages>
					    }
					    {
					        for $REFCONTROL in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/REFCONTROL
					        return
					            <transactionId>{ data($REFCONTROL) }</transactionId>
					    }
					</ns1:ResponseHeader>
					)
					else if (fn:upper-case(data($STATUS)) = 'PENDING' or fn:upper-case(data($STATUS)) = 'REVERSED.PENDING' )then(                              
					<ns1:ResponseHeader>            
					    {
					        for $STATUS in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/STATUS
					        return
					            <successIndicator>{ 'PENDING' }</successIndicator>
					    }
					    {
					        for $IDREJECTION in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/IDREJECTION
					        return
					            <messages>{ data($IDREJECTION) }</messages>
					    }
					    {
					        for $REFCONTROL in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/REFCONTROL
					        return
					            <transactionId>{ data($REFCONTROL) }</transactionId>
					    }
					</ns1:ResponseHeader>
					)
					else if (fn:upper-case(data($STATUS)) = 'NO RECORDS')then(                              
					<ns1:ResponseHeader>            
					    {
					        for $STATUS in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/STATUS
					        return
					            <successIndicator>{'30022'}</successIndicator>
					    }
					    {
					            <messages>{ 'NO RECORDS' }</messages>
					    }
					    {
					        for $REFCONTROL in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/REFCONTROL
					        return
					            <transactionId>{ data($REFCONTROL) }</transactionId>
					    }
					</ns1:ResponseHeader>
					)
					else if (fn:upper-case(data($STATUS)) = 'REJECTED')then(                              
					<ns1:ResponseHeader>            
					    {
					        for $STATUS in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/STATUS
					        return
					            <successIndicator>{ 'ERROR' }</successIndicator>
					    }
					    {
					     	for $IDREJECTION in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/IDREJECTION
					        return
					            <messages>{ data($IDREJECTION) }</messages>
					    }
					    {
					        for $REFCONTROL in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/REFCONTROL
					        return
					            <transactionId>{ data($REFCONTROL) }</transactionId>
					    }
					</ns1:ResponseHeader>
					)
	                else
	                (
	                <ns1:ResponseHeader>            
					    {
					        for $STATUS in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/STATUS
					        return
					            <successIndicator>{ data($STATUS) }</successIndicator>
					    }
					    {
					        for $IDREJECTION in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/IDREJECTION
					        return
					            <messages>{ data($IDREJECTION) }</messages>
					    }
					    {
					        for $REFCONTROL in $consultaEstadoTransaccionACHResponse1/FICOACHGETSTATUSTICKETWSType[1]/gFICOACHGETSTATUSTICKETWSDetailType/mFICOACHGETSTATUSTICKETWSDetailType[1]/REFCONTROL
					        return
					            <transactionId>{ data($REFCONTROL) }</transactionId>
					    }
					</ns1:ResponseHeader>                
	                )
	        )
	        )
        else(
         		    <ns1:ResponseHeader>            
					    {					      
					            <successIndicator>{ data($consultaEstadoTransaccionACHResponse1/Status/successIndicator) }</successIndicator>
					    }
					    {					       
					            <messages>{ data($consultaEstadoTransaccionACHResponse1/Status/messages) }</messages>
					    }					    
					</ns1:ResponseHeader>             
	        )
};

declare variable $consultaEstadoTransaccionACHResponse1 as element(ns0:ConsultaEstadoTransaccionACHResponse) external;

xf:ConsultaEstadoTransaccionACH_T24Out($consultaEstadoTransaccionACHResponse1)
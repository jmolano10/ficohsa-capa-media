xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoRespuesta1" element="ns0:consultaRecaudoRespuesta" location="../../../../BusinessServices/CTS/convenio/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:consultaPaquetesMovilResponse" location="../xsd/consultaPaquetesMovilTypes.xsd" ::)

declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/consultaPaquetesTypes";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns0 = "http://service.srvaplcobisrecaudo.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PaquetesMovil/ConsultaPaquetes/xq/consultaPaquetesMovilOutNi/";

declare function xf:consultaPaquetesMovilOutNi($consultaRecaudoRespuesta1 as element(ns0:consultaRecaudoRespuesta))
    as element(ns4:consultaPaquetesMovilResponse) {
        <ns4:consultaPaquetesMovilResponse>
            <ns4:consultaPaquetesMovilResponseType>
           		 {
	                for $consultaPaquetesResponse at $i in $consultaRecaudoRespuesta1/ns2:bills/ns2:billRecord   
	             	return
		                <ns4:consultaPaquetesMovilResponseRecordType>
		                    {
		                        for $billDescription in $consultaPaquetesResponse/ns2:billDescription
		                        return
		                            <CARRIER_NAME>CLARO</CARRIER_NAME>
		                    }
		                    {
		                        for $billDescription in $consultaPaquetesResponse/ns2:billDescription
		                        return
		                            <PACK_NAME>{ data($billDescription) }</PACK_NAME>
		                    }
		                    {
		                        for $billNumber in $consultaPaquetesResponse/ns2:billNumber
		                        return
		                            <PACK_CODE>{ data($billNumber) }</PACK_CODE>
		                    }
		                    {
		                        for $billDescription in $consultaPaquetesResponse/ns2:billDescription
		                        return
		                            	<PACK_TYPE>{fn:concat("0",$i )}</PACK_TYPE>
		                    }
		                    {
		                        for $billAmount in $consultaPaquetesResponse/ns2:billAmount
		                        return
		                            <PACK_PRICE>{ data($billAmount) }</PACK_PRICE>
		                    }
		                   	{
		                       for $billDescription in $consultaPaquetesResponse/ns2:billDescription
		                        return
		                            <PACK_RANKING>{$i }</PACK_RANKING>
		                            
		                    }
		                    {
		                        for  $billAmount in $consultaPaquetesResponse/ns2:billAmount
			                        return
			                            <PACK_STATUS>ACTIVO</PACK_STATUS>
		                    }
		                </ns4:consultaPaquetesMovilResponseRecordType>
	               }
            </ns4:consultaPaquetesMovilResponseType>
        </ns4:consultaPaquetesMovilResponse>
};

declare variable $consultaRecaudoRespuesta1 as element(ns0:consultaRecaudoRespuesta) external;

xf:consultaPaquetesMovilOutNi($consultaRecaudoRespuesta1)
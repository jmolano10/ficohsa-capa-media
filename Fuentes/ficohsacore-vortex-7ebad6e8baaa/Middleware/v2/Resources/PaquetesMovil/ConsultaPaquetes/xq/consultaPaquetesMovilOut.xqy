xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPaquetesMovilesResponse" element="ns0:ConsultaPaquetesMovilesResponse" location="../../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPaquetesMovilResponse" location="../xsd/consultaPaquetesMovilTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPaquetesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PaquetesMovil/ConsultaPaquetes/xq/consultaPaquetesMovilOut/";

declare function xf:consultaPaquetesMovilOut($consultaPaquetesMovilesResponse as element(ns0:ConsultaPaquetesMovilesResponse), $packType as xs:string)
    as element(ns1:consultaPaquetesMovilResponse) {
        <ns1:consultaPaquetesMovilResponse>
            <ns1:consultaPaquetesMovilResponseType>
                {
                	if ($packType = "") then
	                    for $mWSFICOPARAMPACKAGEDetailType in $consultaPaquetesMovilesResponse/WSFICOPARAMPACKAGEType[1]/gWSFICOPARAMPACKAGEDetailType/mWSFICOPARAMPACKAGEDetailType
	                    return
	                        <ns1:consultaPaquetesMovilResponseRecordType>
	                            {
	                                for $CARRIERNAME in $mWSFICOPARAMPACKAGEDetailType/CARRIERNAME
	                                return
	                                    <CARRIER_NAME>{ data($CARRIERNAME) }</CARRIER_NAME>
	                            }
	                            {
	                                for $PACKNAME in $mWSFICOPARAMPACKAGEDetailType/PACKNAME
	                                return
	                                    <PACK_NAME>{ data($PACKNAME) }</PACK_NAME>
	                            }
	                            {
	                                for $PACKOPERCODE in $mWSFICOPARAMPACKAGEDetailType/PACKOPERCODE
	                                return
	                                    <PACK_CODE>{ data($PACKOPERCODE) }</PACK_CODE>
	                            }
	                            {
	                                for $PACKTYPE in $mWSFICOPARAMPACKAGEDetailType/PACKTYPE
	                                return
	                                    <PACK_TYPE>{ data($PACKTYPE) }</PACK_TYPE>
	                            }
	                            {
	                                for $PACKPRICE in $mWSFICOPARAMPACKAGEDetailType/PACKPRICE
	                                return
	                                    <PACK_PRICE>{ data($PACKPRICE) }</PACK_PRICE>
	                            }
	                            {
		                            for $PACKESTADO in $mWSFICOPARAMPACKAGEDetailType/PACKESTADO
		                            return
		                                <PACK_STATUS>{ data($PACKESTADO) }</PACK_STATUS>
		                        }
		                        {
		                            for $PACKPRIORITY in $mWSFICOPARAMPACKAGEDetailType/PACKPRIORITY
		                            return
		                                <PACK_RANKING>{ data($PACKPRIORITY) }</PACK_RANKING>
		                        }
	                        </ns1:consultaPaquetesMovilResponseRecordType>
                     else 
                     	  for $mWSFICOPARAMPACKAGEDetailType in $consultaPaquetesMovilesResponse/WSFICOPARAMPACKAGEType[1]/gWSFICOPARAMPACKAGEDetailType/mWSFICOPARAMPACKAGEDetailType
                     	  where $mWSFICOPARAMPACKAGEDetailType/PACKTYPE/text() = $packType
		                    return
		                        <ns1:consultaPaquetesMovilResponseRecordType>
		                            {
		                                for $CARRIERNAME in $mWSFICOPARAMPACKAGEDetailType/CARRIERNAME
		                                return
		                                    <CARRIER_NAME>{ data($CARRIERNAME) }</CARRIER_NAME>
		                            }
		                            {
		                                for $PACKNAME in $mWSFICOPARAMPACKAGEDetailType/PACKNAME
		                                return
		                                    <PACK_NAME>{ data($PACKNAME) }</PACK_NAME>
		                            }
		                            {
		                                for $PACKOPERCODE in $mWSFICOPARAMPACKAGEDetailType/PACKOPERCODE
		                                return
		                                    <PACK_CODE>{ data($PACKOPERCODE) }</PACK_CODE>
		                            }
		                            {
		                                for $PACKTYPE in $mWSFICOPARAMPACKAGEDetailType/PACKTYPE
		                                return
		                                    <PACK_TYPE>{ data($PACKTYPE) }</PACK_TYPE>
		                            }
		                            {
		                                for $PACKPRICE in $mWSFICOPARAMPACKAGEDetailType/PACKPRICE
		                                return
		                                    <PACK_PRICE>{ data($PACKPRICE) }</PACK_PRICE>
		                            }
		                            {
		                                for $PACKESTADO in $mWSFICOPARAMPACKAGEDetailType/PACKESTADO
		                                return
		                                    <PACK_STATUS>{ data($PACKESTADO) }</PACK_STATUS>
		                            }
		                            {
		                                for $PACKPRIORITY in $mWSFICOPARAMPACKAGEDetailType/PACKPRIORITY
		                                return
		                                    <PACK_RANKING>{ data($PACKPRIORITY) }</PACK_RANKING>
		                            }
		                        </ns1:consultaPaquetesMovilResponseRecordType>
                }
            </ns1:consultaPaquetesMovilResponseType>
        </ns1:consultaPaquetesMovilResponse>
};

declare variable $consultaPaquetesMovilesResponse as element(ns0:ConsultaPaquetesMovilesResponse) external;
declare variable $packType as xs:string external;

xf:consultaPaquetesMovilOut($consultaPaquetesMovilesResponse, $packType)
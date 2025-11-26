(:: pragma bea:global-element-parameter parameter="$consultadeimagenesResponse" element="ns1:ConsultadeimagenesResponse" location="../Resources/XMLSchema_1601969511.xsd" ::)
(:: pragma  parameter="$images" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:consultaImagenFirmasResponse" location="consultaImagenFirmasTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaImagenFirmasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasImagen/ConsultaImagenFirmas/consultaImagenFirmasOut/";

declare function xf:consultaImagenFirmasOut($consultadeimagenesResponse as element(ns1:ConsultadeimagenesResponse),
    $serverPath as xs:string)
    as element(ns0:consultaImagenFirmasResponse) {
        <ns0:consultaImagenFirmasResponse>
            {
                for $ACCOUNTNAME in $consultadeimagenesResponse/WSFICOIMAGEVIEWDESCType[1]/ACCOUNTNAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTNAME) }</ACCOUNT_NAME>
            }        
            {
                for $REQUIREDSIGN in $consultadeimagenesResponse/WSFICOIMAGEVIEWDESCType[1]/REQUIREDSIGN
                return
                    <REQUIRED_SIGNATURE>{ data($REQUIREDSIGN) }</REQUIRED_SIGNATURE>
            }
            {
                for $REGISTEREDSIGN in $consultadeimagenesResponse/WSFICOIMAGEVIEWDESCType[1]/REGISTEREDSIGN
                return
                    <REGISTERED_SIGNATURE>{ data($REGISTEREDSIGN) }</REGISTERED_SIGNATURE>
            }
			{
                for $SIGNATUREDESC in $consultadeimagenesResponse/WSFICOIMAGEVIEWDESCType[1]/SIGNATUREDESC
                return
                    <SIGNATURE_DESCRIPTION>{ data($SIGNATUREDESC) }</SIGNATURE_DESCRIPTION>
            }            
            <ns0:consultaImagenFirmasResponseType>
                {
                    for $mWSFICOIMAGEVIEWDESCDetailType at $i in $consultadeimagenesResponse/WSFICOIMAGEVIEWDESCType[1]/gWSFICOIMAGEVIEWDESCDetailType/mWSFICOIMAGEVIEWDESCDetailType
                    return
                        <ns0:consultaImagenFirmasResponseRecordType>
                            {
                                for $SIGNTYPE in $mWSFICOIMAGEVIEWDESCDetailType/SIGNTYPE
                                return
                                    <SIGNATURE_TYPE>{ data($SIGNTYPE) }</SIGNATURE_TYPE>
                            }
                            {
                                for $SIGNNAME in $mWSFICOIMAGEVIEWDESCDetailType/SIGNNAME
                                return
                                    <SIGNATURE_NAME>{ data($SIGNNAME) }</SIGNATURE_NAME>
                            }
							{
                                for $IMAGELOCATION in $mWSFICOIMAGEVIEWDESCDetailType/IMAGELOCATION
                                return
                                    <SIGNATURE_IMAGE>{ concat($serverPath, substring($IMAGELOCATION,2)) }</SIGNATURE_IMAGE>
                            }
                            {
                                let $IMAGELOCATION := $mWSFICOIMAGEVIEWDESCDetailType/IMAGELOCATION
                                let $elementos := fn:tokenize($IMAGELOCATION, "\.")
                                let $conteo := count($elementos)
                                return
                                    <FILE_EXTENSION>{ data($elementos[$conteo]) }</FILE_EXTENSION>
                            }
                        </ns0:consultaImagenFirmasResponseRecordType>
                }
            </ns0:consultaImagenFirmasResponseType>
        </ns0:consultaImagenFirmasResponse>
};

declare variable $consultadeimagenesResponse as element(ns1:ConsultadeimagenesResponse) external;
declare variable $serverPath as xs:string external;

xf:consultaImagenFirmasOut($consultadeimagenesResponse,
    $serverPath)
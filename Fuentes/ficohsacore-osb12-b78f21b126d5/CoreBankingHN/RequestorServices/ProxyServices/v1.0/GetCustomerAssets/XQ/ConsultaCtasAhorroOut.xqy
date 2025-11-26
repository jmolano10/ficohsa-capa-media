xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerAssetsDynamo/getCustomerAssetsDynamo.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
(:: import schema at "../XSD/sjConsultaActivosCliente.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/ConsultasCtasAhorroOut";

declare variable $ConsultadectasahorroporclienteResponse as element() (:: schema-element(ns2:ConsultaClienteCuentasdeAhorroResponse) ::) external;

declare function ns1:consultasCtasAhorroOut($ConsultadectasahorroporclienteResponse as element() (:: schema-element(ns2:ConsultaClienteCuentasdeAhorroResponse) ::)) as element() (:: schema-element(ns3:sjConsultaActivosClienteResponse) ::) {
    <ns3:sjConsultaActivosClienteResponse>
        <ns3:consultaCuentaAhorrosResponse>
            {
                if ($ConsultadectasahorroporclienteResponse/Status/successIndicator and data($ConsultadectasahorroporclienteResponse/Status/successIndicator) = 'Success' and not($ConsultadectasahorroporclienteResponse/WSDYNFICOLINKSAVINGSACCTType/gWSDYNFICOLINKSAVINGSACCTDetailType))
                then <ns3:successIndicator>NoRecords</ns3:successIndicator>
                else if ($ConsultadectasahorroporclienteResponse/Status/successIndicator)
                then <ns3:successIndicator>{fn:data($ConsultadectasahorroporclienteResponse/Status/successIndicator)}</ns3:successIndicator>
                else ()
            }
            {
                for $messages in $ConsultadectasahorroporclienteResponse/Status/messages
                return 
                <ns3:messages>{fn:data($ConsultadectasahorroporclienteResponse/Status/messages)}</ns3:messages>
            }
            <ns3:consultaActivoResponseRecords>
                {
                    for $mWSFICOLINKSAVINGSACCTDetailType in $ConsultadectasahorroporclienteResponse/WSDYNFICOLINKSAVINGSACCTType/gWSDYNFICOLINKSAVINGSACCTDetailType/mWSDYNFICOLINKSAVINGSACCTDetailType
                    return 
                    <ns3:consultaActivoResponseRecord>
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/ALTACCTID and fn:data($mWSFICOLINKSAVINGSACCTDetailType/ALTACCTID) != '')
                            then <ns3:ACCOUNTNUMBER>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/ALTACCTID)}</ns3:ACCOUNTNUMBER>
                            else <ns3:ACCOUNTNUMBER>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/ACCOUNTNUMBER)}</ns3:ACCOUNTNUMBER>
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/ACCOUNTTITLE)
                            then <ns3:ACCOUNTNAME>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/ACCOUNTTITLE)}</ns3:ACCOUNTNAME>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/CURRENCY)
                            then <ns3:CURRENCY>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/CURRENCY)}</ns3:CURRENCY>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/TOTALBALANCE)
                            then <ns3:TOTALBALANCE>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/TOTALBALANCE)}</ns3:TOTALBALANCE>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/RESERVEBALANCE)
                            then <ns3:RESERVEBALANCE>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/RESERVEBALANCE)}</ns3:RESERVEBALANCE>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/LIENBALANCE)
                            then <ns3:LIENBALANCE>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/LIENBALANCE)}</ns3:LIENBALANCE>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSPOS)
                            then <ns3:BLOCKEDFUNDSPOS>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSPOS)}</ns3:BLOCKEDFUNDSPOS>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSATM)
                            then <ns3:BLOCKEDFUNDSATM>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/BLOCKEDFUNDSATM)}</ns3:BLOCKEDFUNDSATM>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/AVAILABLEBAL)
                            then <ns3:AVAILABLEBAL>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/AVAILABLEBAL)}</ns3:AVAILABLEBAL>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/OPERATIONTYPE)
                            then <ns3:PRODUCTTYPE>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/OPERATIONTYPE)}</ns3:PRODUCTTYPE>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/INACT and fn:data($mWSFICOLINKSAVINGSACCTDetailType/INACT) != '')
                            then <ns3:STATUS>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/INACT)}</ns3:STATUS>
                            else (
                              if ($mWSFICOLINKSAVINGSACCTDetailType/RESTTYPE and fn:data($mWSFICOLINKSAVINGSACCTDetailType/RESTTYPE) != '')
                              then <ns3:STATUS>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/RESTTYPE)}</ns3:STATUS>
                              else <ns3:STATUS>A</ns3:STATUS>
                            )
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/ODATE)
                            then <ns3:OPENINGDATE>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/ODATE)}</ns3:OPENINGDATE>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/CATACCT)
                            then <ns3:ACCOUNTCATEGORY>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/CATACCT)}</ns3:ACCOUNTCATEGORY>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/DESCCAT)
                            then <ns3:CATEGORYDESCRIPTION>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/DESCCAT)}</ns3:CATEGORYDESCRIPTION>
                            else ()
                        }
                        {
                            if ($mWSFICOLINKSAVINGSACCTDetailType/PAYROLLGRP)
                            then <ns3:PAYROLLGROUP>{fn:data($mWSFICOLINKSAVINGSACCTDetailType/PAYROLLGRP)}</ns3:PAYROLLGROUP>
                            else ()
                        }
                    </ns3:consultaActivoResponseRecord>
                }
            </ns3:consultaActivoResponseRecords>
        </ns3:consultaCuentaAhorrosResponse>
    </ns3:sjConsultaActivosClienteResponse>
};

ns1:consultasCtasAhorroOut($ConsultadectasahorroporclienteResponse)
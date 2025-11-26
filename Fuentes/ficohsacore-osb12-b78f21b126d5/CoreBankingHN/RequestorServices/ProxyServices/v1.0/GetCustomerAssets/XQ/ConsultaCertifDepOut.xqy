xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerAssets/getCustomerAssets.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
(:: import schema at "../XSD/sjConsultaActivosCliente.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/ConsultasCertifDepOut";

declare variable $ConsultadecertifdepporclienteResponse as element() (:: schema-element(ns2:ConsultadecertifdepporclienteResponse) ::) external;

declare function ns1:consultasCertifDepOut($ConsultadecertifdepporclienteResponse as element() (:: schema-element(ns2:ConsultadecertifdepporclienteResponse) ::)) as element() (:: schema-element(ns3:sjConsultaActivosClienteResponse) ::) {
    <ns3:sjConsultaActivosClienteResponse>
        <ns3:consultaCertifDepositoResponse>
            {
                if ($ConsultadecertifdepporclienteResponse/Status/successIndicator and data($ConsultadecertifdepporclienteResponse/Status/successIndicator) = 'Success' and not($ConsultadecertifdepporclienteResponse/WSFICOTERMDEPOSITType/gWSFICOTERMDEPOSITDetailType))
                then <ns3:successIndicator>NoRecords</ns3:successIndicator>
                else if ($ConsultadecertifdepporclienteResponse/Status/successIndicator)
                then <ns3:successIndicator>{fn:data($ConsultadecertifdepporclienteResponse/Status/successIndicator)}</ns3:successIndicator>
                else ()
            }
            {
                for $messages in $ConsultadecertifdepporclienteResponse/Status/messages
                return 
                <ns3:messages>{fn:data($ConsultadecertifdepporclienteResponse/Status/messages)}</ns3:messages>
            }
            <ns3:consultaActivoResponseRecords>
                {
                    for $mWSFICOTERMDEPOSITDetailType in $ConsultadecertifdepporclienteResponse/WSFICOTERMDEPOSITType/gWSFICOTERMDEPOSITDetailType/mWSFICOTERMDEPOSITDetailType
                    return 
                    <ns3:consultaActivoResponseRecord>
                        {
                            if ($mWSFICOTERMDEPOSITDetailType/DEPOSITNUMBER)
                            then <ns3:ACCOUNTNUMBER>{fn:data($mWSFICOTERMDEPOSITDetailType/DEPOSITNUMBER)}</ns3:ACCOUNTNUMBER>
                            else ()
                        }
                        {
                            if ($mWSFICOTERMDEPOSITDetailType/CUSTOMERNAME)
                            then <ns3:ACCOUNTNAME>{fn:data($mWSFICOTERMDEPOSITDetailType/CUSTOMERNAME)}</ns3:ACCOUNTNAME>
                            else ()
                        }
                        {
                            if ($mWSFICOTERMDEPOSITDetailType/CURRENCY)
                            then <ns3:CURRENCY>{fn:data($mWSFICOTERMDEPOSITDetailType/CURRENCY)}</ns3:CURRENCY>
                            else ()
                        }
                        {
                            if ($mWSFICOTERMDEPOSITDetailType/AMOUNT)
                            then <ns3:TOTALBALANCE>{fn:replace(fn:data($mWSFICOTERMDEPOSITDetailType/AMOUNT),',', '')}</ns3:TOTALBALANCE>
                            else ()
                        }
                        {
                            if ($mWSFICOTERMDEPOSITDetailType/AMOUNT)
                            then <ns3:AVAILABLEBAL>{fn:replace(fn:data($mWSFICOTERMDEPOSITDetailType/AMOUNT),',', '')}</ns3:AVAILABLEBAL>
                            else ()
                        }
                        {
                            if ($mWSFICOTERMDEPOSITDetailType/STARTDATE)
                            then <ns3:OPENINGDATE>{fn:data($mWSFICOTERMDEPOSITDetailType/STARTDATE)}</ns3:OPENINGDATE>
                            else ()
                        }
                    </ns3:consultaActivoResponseRecord>
                }
            </ns3:consultaActivoResponseRecords>
        </ns3:consultaCertifDepositoResponse>
    </ns3:sjConsultaActivosClienteResponse>
};

ns1:consultasCertifDepOut($ConsultadecertifdepporclienteResponse)
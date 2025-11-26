xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerAssetsDynamo/getCustomerAssetsDynamo.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
(:: import schema at "../XSD/sjConsultaActivosCliente.xsd" ::)

declare namespace ns3="http://www.w3.org/2005/ConsultaCtasCorrienteOut";

declare variable $ConsultactascorrienteResponse as element() (:: schema-element(ns1:ConsultaClienteCuentasCorrienteResponse) ::) external;

declare function ns3:consultaCtasCorrienteOut($ConsultactascorrienteResponse as element() (:: schema-element(ns1:ConsultaClienteCuentasCorrienteResponse) ::)) as element() (:: schema-element(ns2:sjConsultaActivosClienteResponse) ::) {
    <ns2:sjConsultaActivosClienteResponse>
        <ns2:consultaCuentaCorrienteResponse>
            {
                if ($ConsultactascorrienteResponse/Status/successIndicator and data($ConsultactascorrienteResponse/Status/successIndicator) = 'Success' and not($ConsultactascorrienteResponse/WSDYNFICOLINKCURRENTACCTType/gWSDYNFICOLINKCURRENTACCTDetailType))
                then <ns2:successIndicator>NoRecords</ns2:successIndicator>
                else if ($ConsultactascorrienteResponse/Status/successIndicator)
                then <ns2:successIndicator>{fn:data($ConsultactascorrienteResponse/Status/successIndicator)}</ns2:successIndicator>
                else ()
            }
            {
                for $messages in $ConsultactascorrienteResponse/Status/messages
                return 
                <ns2:messages>{fn:data($ConsultactascorrienteResponse/Status/messages)}</ns2:messages>
            }
            <ns3:consultaActivoResponseRecords>
                {
                    for $mWSFICOLINKCURRENTACCTDetailType in $ConsultactascorrienteResponse/WSDYNFICOLINKCURRENTACCTType/gWSDYNFICOLINKCURRENTACCTDetailType/mWSDYNFICOLINKCURRENTACCTDetailType
                    return 
                    <ns2:consultaActivoResponseRecord>
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/ALTACCTID)
                        then 
                            if ($mWSFICOLINKCURRENTACCTDetailType/ALTACCTID)
                            then <ns2:ACCOUNTNUMBER>{fn:data($mWSFICOLINKCURRENTACCTDetailType/ACCOUNTNUMBER)}</ns2:ACCOUNTNUMBER>
                            else ()
                        else ()
                    }
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/ACCOUNTNAME)
                        then <ns2:ACCOUNTNAME>{fn:data($mWSFICOLINKCURRENTACCTDetailType/ACCOUNTNAME)}</ns2:ACCOUNTNAME>
                        else ()
                    }
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/CURRENCY)
                        then <ns2:CURRENCY>{fn:data($mWSFICOLINKCURRENTACCTDetailType/CURRENCY)}</ns2:CURRENCY>
                        else ()
                    }
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/TOTALBALANCE)
                        then <ns2:TOTALBALANCE>{fn:data($mWSFICOLINKCURRENTACCTDetailType/TOTALBALANCE)}</ns2:TOTALBALANCE>
                        else ()
                    }
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/RESERVEBALANCE)
                        then <ns2:RESERVEBALANCE>{fn:data($mWSFICOLINKCURRENTACCTDetailType/RESERVEBALANCE)}</ns2:RESERVEBALANCE>
                        else ()
                    }
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/LIENBALANCE)
                        then <ns2:LIENBALANCE>{fn:data($mWSFICOLINKCURRENTACCTDetailType/LIENBALANCE)}</ns2:LIENBALANCE>
                        else ()
                    }
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSPOS)
                        then <ns2:BLOCKEDFUNDSPOS>{fn:data($mWSFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSPOS)}</ns2:BLOCKEDFUNDSPOS>
                        else ()
                    }
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSATM)
                        then <ns2:BLOCKEDFUNDSATM>{fn:data($mWSFICOLINKCURRENTACCTDetailType/BLOCKEDFUNDSATM)}</ns2:BLOCKEDFUNDSATM>
                        else ()
                    }
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/AVAILABLEBALANCE)
                        then <ns2:AVAILABLEBAL>{fn:data($mWSFICOLINKCURRENTACCTDetailType/AVAILABLEBALANCE)}</ns2:AVAILABLEBAL>
                        else ()
                    } 
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/INACT and $mWSFICOLINKCURRENTACCTDetailType/INACT = 'Y') then (
                          <ns2:STATUS>INACTIVE</ns2:STATUS>
                        )
                        else if ($mWSFICOLINKCURRENTACCTDetailType/INACT and $mWSFICOLINKCURRENTACCTDetailType/INACT = 'N') then (
                          <ns2:STATUS>ACTIVE</ns2:STATUS>
                        )
                        else (
                          <ns2:STATUS>ACTIVE</ns2:STATUS>
                        )
                    } 
                    {
                        if ($mWSFICOLINKCURRENTACCTDetailType/ODATE)
                        then <ns2:OPENINGDATE>{fn:data($mWSFICOLINKCURRENTACCTDetailType/ODATE)}</ns2:OPENINGDATE>
                        else ()
                    }
                    </ns2:consultaActivoResponseRecord>
                }
            </ns3:consultaActivoResponseRecords>
        </ns2:consultaCuentaCorrienteResponse>
    </ns2:sjConsultaActivosClienteResponse>
};

ns3:consultaCtasCorrienteOut($ConsultactascorrienteResponse)
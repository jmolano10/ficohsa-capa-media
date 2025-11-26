xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerAssets/getCustomerAssets.xsd" ::)
declare namespace ns3="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../../../../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns4="http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
(:: import schema at "../XSD/sjConsultaActivosCliente.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/ConsultaActivosClienteSJOut";

declare variable $ConsultactascorrienteporclienteResponse as element() (:: schema-element(ns4:sjConsultaActivosClienteResponse) ::) external;
declare variable $ConsultadecertifdepporclienteResponse as element() (:: schema-element(ns2:ConsultadecertifdepporclienteResponse) ::) external;
declare variable $ConsultadectasahorroporclienteResponse as element() (:: schema-element(ns4:sjConsultaActivosClienteResponse) ::) external;
declare variable $assetType as xs:string external;

declare function ns1:consultaActivosClienteSJOut($ConsultactascorrienteporclienteResponse as element() (:: schema-element(ns4:sjConsultaActivosClienteResponse) ::), 
                                                 $ConsultadecertifdepporclienteResponse as element() (:: schema-element(ns2:ConsultadecertifdepporclienteResponse) ::), 
                                                 $ConsultadectasahorroporclienteResponse as element() (:: schema-element(ns4:sjConsultaActivosClienteResponse) ::), 
                                                 $assetType as xs:string)
                                                 as element() (:: schema-element(ns4:sjConsultaActivosClienteResponse) ::) {
    <ns4:sjConsultaActivosClienteResponse>
        {
            if ($ConsultadectasahorroporclienteResponse/ns4:consultaCuentaAhorrosResponse)
            then 
                <ns4:consultaCuentaAhorrosResponse>
                    {
                        if ($ConsultadectasahorroporclienteResponse/ns4:consultaCuentaAhorrosResponse/ns4:successIndicator)
                        then <ns4:successIndicator>{fn:data($ConsultadectasahorroporclienteResponse/ns4:consultaCuentaAhorrosResponse/ns4:successIndicator)}</ns4:successIndicator>
                        else ()
                    }
                    {
                        for $messages in $ConsultadectasahorroporclienteResponse/ns4:consultaCuentaAhorrosResponse/ns4:messages
                        return 
                        <ns4:messages>{fn:data($ConsultadectasahorroporclienteResponse/ns4:consultaCuentaAhorrosResponse/ns4:messages)}</ns4:messages>
                    }
                    {
                        if ($ConsultadectasahorroporclienteResponse/ns4:consultaCuentaAhorrosResponse/ns4:consultaActivoResponseRecords)
                        then 
                            <ns4:consultaActivoResponseRecords>
                                {
                                    for $consultaActivoResponseRecord in $ConsultadectasahorroporclienteResponse/ns4:consultaCuentaAhorrosResponse/ns4:consultaActivoResponseRecords/ns4:consultaActivoResponseRecord
                                    return 
                                    <ns4:consultaActivoResponseRecord>
                                        {
                                            if ($consultaActivoResponseRecord/ns4:ACCOUNTNUMBER)
                                            then <ns4:ACCOUNTNUMBER>{fn:data($consultaActivoResponseRecord/ns4:ACCOUNTNUMBER)}</ns4:ACCOUNTNUMBER>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:ACCOUNTNAME)
                                            then <ns4:ACCOUNTNAME>{fn:data($consultaActivoResponseRecord/ns4:ACCOUNTNAME)}</ns4:ACCOUNTNAME>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:CURRENCY)
                                            then <ns4:CURRENCY>{fn:data($consultaActivoResponseRecord/ns4:CURRENCY)}</ns4:CURRENCY>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:TOTALBALANCE)
                                            then <ns4:TOTALBALANCE>{fn:data($consultaActivoResponseRecord/ns4:TOTALBALANCE)}</ns4:TOTALBALANCE>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:RESERVEBALANCE)
                                            then <ns4:RESERVEBALANCE>{fn:data($consultaActivoResponseRecord/ns4:RESERVEBALANCE)}</ns4:RESERVEBALANCE>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:LIENBALANCE)
                                            then <ns4:LIENBALANCE>{fn:data($consultaActivoResponseRecord/ns4:LIENBALANCE)}</ns4:LIENBALANCE>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:BLOCKEDFUNDSPOS)
                                            then <ns4:BLOCKEDFUNDSPOS>{fn:data($consultaActivoResponseRecord/ns4:BLOCKEDFUNDSPOS)}</ns4:BLOCKEDFUNDSPOS>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:BLOCKEDFUNDSATM)
                                            then <ns4:BLOCKEDFUNDSATM>{fn:data($consultaActivoResponseRecord/ns4:BLOCKEDFUNDSATM)}</ns4:BLOCKEDFUNDSATM>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:AVAILABLEBAL)
                                            then <ns4:AVAILABLEBAL>{fn:data($consultaActivoResponseRecord/ns4:AVAILABLEBAL)}</ns4:AVAILABLEBAL>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:PRODUCTTYPE)
                                            then <ns4:PRODUCTTYPE>{fn:data($consultaActivoResponseRecord/ns4:PRODUCTTYPE)}</ns4:PRODUCTTYPE>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:STATUS)
                                            then <ns4:STATUS>{fn:data($consultaActivoResponseRecord/ns4:STATUS)}</ns4:STATUS>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:OPENINGDATE)
                                            then <ns4:OPENINGDATE>{fn:data($consultaActivoResponseRecord/ns4:OPENINGDATE)}</ns4:OPENINGDATE>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:ACCOUNTCATEGORY)
                                            then <ns4:ACCOUNTCATEGORY>{fn:data($consultaActivoResponseRecord/ns4:ACCOUNTCATEGORY)}</ns4:ACCOUNTCATEGORY>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:CATEGORYDESCRIPTION)
                                            then <ns4:CATEGORYDESCRIPTION>{fn:data($consultaActivoResponseRecord/ns4:CATEGORYDESCRIPTION)}</ns4:CATEGORYDESCRIPTION>
                                            else ()
                                        }
                                        {
                                            if ($consultaActivoResponseRecord/ns4:PAYROLLGROUP)
                                            then <ns4:PAYROLLGROUP>{fn:data($consultaActivoResponseRecord/ns4:PAYROLLGROUP)}</ns4:PAYROLLGROUP>
                                            else ()
                                        }
                                    </ns4:consultaActivoResponseRecord>
                                }
                            </ns4:consultaActivoResponseRecords>
                        else ()
                    }
                </ns4:consultaCuentaAhorrosResponse>
            else ()
        }
        <ns4:consultaCuentaCorrienteResponse>
            {
                if ($ConsultactascorrienteporclienteResponse/ns4:consultaCuentaCorrienteResponse/ns4:successIndicator)
                then <ns4:successIndicator>{fn:data($ConsultactascorrienteporclienteResponse/ns4:consultaCuentaCorrienteResponse/ns4:successIndicator)}</ns4:successIndicator>
                else ()
            }
            
            {
                for $messages in $ConsultactascorrienteporclienteResponse/ns4:consultaCuentaCorrienteResponse/ns4:messages
                return 
                <ns4:messages>{fn:data($ConsultactascorrienteporclienteResponse/ns4:consultaCuentaCorrienteResponse/ns4:messages)}</ns4:messages>
            }
            
                <ns4:consultaActivoResponseRecords>
                  {
                     for $consultaActivoResponseRecord in $ConsultactascorrienteporclienteResponse/ns4:consultaCuentaCorrienteResponse/*:consultaActivoResponseRecords/ns4:consultaActivoResponseRecord
                     return 
                     <ns4:consultaActivoResponseRecord>
                  {
                     if ($consultaActivoResponseRecord/ns4:ACCOUNTNUMBER)
                     then <ns4:ACCOUNTNUMBER>{fn:data($consultaActivoResponseRecord/ns4:ACCOUNTNUMBER)}</ns4:ACCOUNTNUMBER>
                     else ()
                  }
                  {
                     if ($consultaActivoResponseRecord/ns4:ACCOUNTNAME)
                     then <ns4:ACCOUNTNAME>{fn:data($consultaActivoResponseRecord/ns4:ACCOUNTNAME)}</ns4:ACCOUNTNAME>
                     else ()
                  }
                  {
                      if ($consultaActivoResponseRecord/ns4:CURRENCY)
                      then <ns4:CURRENCY>{fn:data($consultaActivoResponseRecord/ns4:CURRENCY)}</ns4:CURRENCY>
                      else ()
                   }
                   {
                       if ($consultaActivoResponseRecord/ns4:TOTALBALANCE)
                       then <ns4:TOTALBALANCE>{fn:data($consultaActivoResponseRecord/ns4:TOTALBALANCE)}</ns4:TOTALBALANCE>
                       else ()
                    }
                    {
                       if ($consultaActivoResponseRecord/ns4:RESERVEBALANCE)
                       then <ns4:RESERVEBALANCE>{fn:data($consultaActivoResponseRecord/ns4:RESERVEBALANCE)}</ns4:RESERVEBALANCE>
                       else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns4:LIENBALANCE)
                        then <ns4:LIENBALANCE>{fn:data($consultaActivoResponseRecord/ns4:LIENBALANCE)}</ns4:LIENBALANCE>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns4:BLOCKEDFUNDSPOS)
                        then <ns4:BLOCKEDFUNDSPOS>{fn:data($consultaActivoResponseRecord/ns4:BLOCKEDFUNDSPOS)}</ns4:BLOCKEDFUNDSPOS>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns4:BLOCKEDFUNDSATM)
                        then <ns4:BLOCKEDFUNDSATM>{fn:data($consultaActivoResponseRecord/ns4:BLOCKEDFUNDSATM)}</ns4:BLOCKEDFUNDSATM>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns4:AVAILABLEBAL)
                        then <ns4:AVAILABLEBAL>{fn:data($consultaActivoResponseRecord/ns4:AVAILABLEBAL)}</ns4:AVAILABLEBAL>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns4:PRODUCTTYPE)
                        then <ns4:PRODUCTTYPE>{fn:data($consultaActivoResponseRecord/ns4:PRODUCTTYPE)}</ns4:PRODUCTTYPE>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns4:STATUS)
                        then <ns4:STATUS>{fn:data($consultaActivoResponseRecord/ns4:STATUS)}</ns4:STATUS>
                        else ()
                     }
                     {
                        if ($consultaActivoResponseRecord/ns4:OPENINGDATE)
                        then <ns4:OPENINGDATE>{fn:data($consultaActivoResponseRecord/ns4:OPENINGDATE)}</ns4:OPENINGDATE>
                        else ()
                     }
                     {
                         if ($consultaActivoResponseRecord/ns4:ACCOUNTCATEGORY)
                         then <ns4:ACCOUNTCATEGORY>{fn:data($consultaActivoResponseRecord/ns4:ACCOUNTCATEGORY)}</ns4:ACCOUNTCATEGORY>
                         else ()
                      }
                      {
                         if ($consultaActivoResponseRecord/ns4:CATEGORYDESCRIPTION)
                         then <ns4:CATEGORYDESCRIPTION>{fn:data($consultaActivoResponseRecord/ns4:CATEGORYDESCRIPTION)}</ns4:CATEGORYDESCRIPTION>
                         else ()
                      }
                      {
                         if ($consultaActivoResponseRecord/ns4:PAYROLLGROUP)
                         then <ns4:PAYROLLGROUP>{fn:data($consultaActivoResponseRecord/ns4:PAYROLLGROUP)}</ns4:PAYROLLGROUP>
                         else ()
                     }
                 </ns4:consultaActivoResponseRecord>
                }
             </ns4:consultaActivoResponseRecords>                
        </ns4:consultaCuentaCorrienteResponse>
        <ns4:consultaCertifDepositoResponse>
            {
                if (fn:data($assetType) != 'Accounts') then
                  if ($ConsultadecertifdepporclienteResponse/Status/successIndicator and data($ConsultadecertifdepporclienteResponse/Status/successIndicator) = 'Success' and not($ConsultadecertifdepporclienteResponse/WSFICOTERMDEPOSITType/gWSFICOTERMDEPOSITDetailType))
                  then <ns4:successIndicator>NoRecords</ns4:successIndicator>
                  else if ($ConsultadecertifdepporclienteResponse/Status/successIndicator)
                  then <ns4:successIndicator>{fn:data($ConsultadecertifdepporclienteResponse/Status/successIndicator)}</ns4:successIndicator>
                  else ()
                else ()
            }
            {
                if (fn:data($assetType) != 'Accounts') then
                  for $messages2 in $ConsultadecertifdepporclienteResponse/Status/messages
                  return 
                  <ns4:messages>{fn:data($ConsultadecertifdepporclienteResponse/Status/messages)}</ns4:messages>
                else ()
            }
            <ns4:consultaActivoResponseRecords>
                {
                    if (fn:data($assetType) != 'Accounts') then
                      for $mWSFICOTERMDEPOSITDetailType in $ConsultadecertifdepporclienteResponse/WSFICOTERMDEPOSITType/gWSFICOTERMDEPOSITDetailType/mWSFICOTERMDEPOSITDetailType
                      return 
                      <ns4:consultaActivoResponseRecord>
                          {
                              if ($mWSFICOTERMDEPOSITDetailType/DEPOSITNUMBER)
                              then <ns4:ACCOUNTNUMBER>{fn:data($mWSFICOTERMDEPOSITDetailType/DEPOSITNUMBER)}</ns4:ACCOUNTNUMBER>
                              else ()
                          }
                          {
                              if ($mWSFICOTERMDEPOSITDetailType/CUSTOMERNAME)
                              then <ns4:ACCOUNTNAME>{fn:data($mWSFICOTERMDEPOSITDetailType/CUSTOMERNAME)}</ns4:ACCOUNTNAME>
                              else ()
                          }
                          {
                              if ($mWSFICOTERMDEPOSITDetailType/CURRENCY)
                              then <ns4:CURRENCY>{fn:data($mWSFICOTERMDEPOSITDetailType/CURRENCY)}</ns4:CURRENCY>
                              else ()
                          }
                          {
                              if ($mWSFICOTERMDEPOSITDetailType/AMOUNT)
                              then <ns4:TOTALBALANCE>{fn:replace(fn:data($mWSFICOTERMDEPOSITDetailType/AMOUNT),',', '')}</ns4:TOTALBALANCE>
                              else ()
                          }
                          {
                              if ($mWSFICOTERMDEPOSITDetailType/AMOUNT)
                              then <ns4:AVAILABLEBAL>{fn:replace(fn:data($mWSFICOTERMDEPOSITDetailType/AMOUNT),',', '')}</ns4:AVAILABLEBAL>
                              else ()
                          }
                          {
                              if ($mWSFICOTERMDEPOSITDetailType/STARTDATE)
                              then <ns4:OPENINGDATE>{fn:data($mWSFICOTERMDEPOSITDetailType/STARTDATE)}</ns4:OPENINGDATE>
                              else ()
                          }
                      </ns4:consultaActivoResponseRecord>
                    else ()
                }
            </ns4:consultaActivoResponseRecords>
        </ns4:consultaCertifDepositoResponse>
    </ns4:sjConsultaActivosClienteResponse>
};

ns1:consultaActivosClienteSJOut($ConsultactascorrienteporclienteResponse, $ConsultadecertifdepporclienteResponse, $ConsultadectasahorroporclienteResponse, $assetType)
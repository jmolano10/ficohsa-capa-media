(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteResponseOUT" element="ns1:consultaActivosClienteResponse" location="../../../../Resources/ConsultaActivosCliente/xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaActivosPasivosClienteResponse" location="../xsd/sjConsultaActivosPasivosCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xq/ConsultaActivosClienteOUT/";

declare function xf:ConsultaActivosClienteOUT($consultaActivosClienteResponseOUT as element(ns1:consultaActivosClienteResponse),
$TypeSerch as xs:string)
    as element(ns0:sjConsultaActivosPasivosClienteResponse) {
        <ns0:sjConsultaActivosPasivosClienteResponse>
            <ns0:ASSETS_INFORMATION>
              <ns0:ASSET>
              {
              if ($TypeSerch='ALL' or $TypeSerch='AHO' or $TypeSerch='CTA'  ) then(
                <ns0:consultaActivosClienteAhorrosResponseType>
                    {
                        for $SUCCESS_INDICATOR in $consultaActivosClienteResponseOUT/ns1:consultaActivosClienteAhorrosResponseType/SUCCESS_INDICATOR
                        return
                            <ns0:SUCCESS_INDICATOR>{ data($SUCCESS_INDICATOR) }</ns0:SUCCESS_INDICATOR>
                    }
                    {
                    for $consultaActivosClienteResponseRecord in $consultaActivosClienteResponseOUT/ns1:consultaActivosClienteAhorrosResponseType/ns1:consultaActivosClienteResponseRecordType
                         return
                    <ns0:consultaActivosClienteResponseRecordType>
                        {
                            for $ASSET_TYPE in $consultaActivosClienteResponseRecord/ASSET_TYPE
                            return
                                <ns0:ASSET_TYPE>{ data($ASSET_TYPE) }</ns0:ASSET_TYPE>
                        }
                        {
                            for $ASSET_NUMBER in $consultaActivosClienteResponseRecord/ASSET_NUMBER
                            return
                                <ns0:ASSET_NUMBER>{ data($ASSET_NUMBER) }</ns0:ASSET_NUMBER>
                        }
                        {
                            for $ASSET_NAME in $consultaActivosClienteResponseRecord/ASSET_NAME
                            return
                                <ns0:ASSET_NAME>{ data($ASSET_NAME) }</ns0:ASSET_NAME>
                        }
                        {
                            for $ASSET_CURRENCY in $consultaActivosClienteResponseRecord/ASSET_CURRENCY
                            return
                                <ns0:ASSET_CURRENCY>{ data($ASSET_CURRENCY) }</ns0:ASSET_CURRENCY>
                        }
                        {
                            for $ASSET_TOTAL_BALANCE in $consultaActivosClienteResponseRecord/ASSET_TOTAL_BALANCE
                            return
                                <ns0:ASSET_TOTAL_BALANCE>{ data($ASSET_TOTAL_BALANCE) }</ns0:ASSET_TOTAL_BALANCE>
                        }
                        {
                            for $ASSET_RESERVE_BALANCE in $consultaActivosClienteResponseRecord/ASSET_RESERVE_BALANCE
                            return
                                <ns0:ASSET_RESERVE_BALANCE>{ data($ASSET_RESERVE_BALANCE) }</ns0:ASSET_RESERVE_BALANCE>
                        }
                        {
                            for $ASSET_LOCKED_BALANCE in $consultaActivosClienteResponseRecord/ASSET_LOCKED_BALANCE
                            return
                                <ns0:ASSET_LOCKED_BALANCE>{ data($ASSET_LOCKED_BALANCE) }</ns0:ASSET_LOCKED_BALANCE>
                        }
                        {
                            for $ASSET_VISA_FLOATING_BALANCE in $consultaActivosClienteResponseRecord/ASSET_VISA_FLOATING_BALANCE
                            return
                                <ns0:ASSET_VISA_FLOATING_BALANCE>{ data($ASSET_VISA_FLOATING_BALANCE) }</ns0:ASSET_VISA_FLOATING_BALANCE>
                        }
                        {
                            for $ASSET_AVAILABLE_BALANCE in $consultaActivosClienteResponseRecord/ASSET_AVAILABLE_BALANCE
                            return
                                <ns0:ASSET_AVAILABLE_BALANCE>{ data($ASSET_AVAILABLE_BALANCE) }</ns0:ASSET_AVAILABLE_BALANCE>
                        }
                        {
                            for $ASSET_SOURCE_BANK in $consultaActivosClienteResponseRecord/ASSET_SOURCE_BANK
                            return
                                <ns0:ASSET_SOURCE_BANK>{ data($ASSET_SOURCE_BANK) }</ns0:ASSET_SOURCE_BANK>
                        }
                        {
                            for $ASSET_PRODUCT_TYPE in $consultaActivosClienteResponseRecord/ASSET_PRODUCT_TYPE
                            return
                                <ns0:ASSET_PRODUCT_TYPE>{ data($ASSET_PRODUCT_TYPE) }</ns0:ASSET_PRODUCT_TYPE>
                        }
                    </ns0:consultaActivosClienteResponseRecordType>
                     }
                </ns0:consultaActivosClienteAhorrosResponseType>
                )else()
                  }
                  {
                if ($TypeSerch='ALL' or $TypeSerch='CHQ' or $TypeSerch='CTA'  ) then(
                <ns0:consultaActivosClienteCorrienteResponseType>
                    {
                        for $SUCCESS_INDICATOR in $consultaActivosClienteResponseOUT/ns1:consultaActivosClienteCorrienteResponseType/SUCCESS_INDICATOR
                        return
                            <ns0:SUCCESS_INDICATOR>{ data($SUCCESS_INDICATOR) }</ns0:SUCCESS_INDICATOR>
                    }
                    {
                    for $consultaActivosClienteResponseRecord in $consultaActivosClienteResponseOUT/ns1:consultaActivosClienteCorrienteResponseType/ns1:consultaActivosClienteResponseRecordType
                         return
                    <ns0:consultaActivosClienteResponseRecordType>
                        {
                            for $ASSET_TYPE in $consultaActivosClienteResponseRecord/ASSET_TYPE
                            return
                                <ns0:ASSET_TYPE>{ data($ASSET_TYPE) }</ns0:ASSET_TYPE>
                        }
                        {
                            for $ASSET_NUMBER in $consultaActivosClienteResponseRecord/ASSET_NUMBER
                            return
                                <ns0:ASSET_NUMBER>{ data($ASSET_NUMBER) }</ns0:ASSET_NUMBER>
                        }
                        {
                            for $ASSET_NAME in $consultaActivosClienteResponseRecord/ASSET_NAME
                            return
                                <ns0:ASSET_NAME>{ data($ASSET_NAME) }</ns0:ASSET_NAME>
                        }
                        {
                            for $ASSET_CURRENCY in $consultaActivosClienteResponseRecord/ASSET_CURRENCY
                            return
                                <ns0:ASSET_CURRENCY>{ data($ASSET_CURRENCY) }</ns0:ASSET_CURRENCY>
                        }
                        {
                            for $ASSET_TOTAL_BALANCE in $consultaActivosClienteResponseRecord/ASSET_TOTAL_BALANCE
                            return
                                <ns0:ASSET_TOTAL_BALANCE>{ data($ASSET_TOTAL_BALANCE) }</ns0:ASSET_TOTAL_BALANCE>
                        }
                        {
                            for $ASSET_RESERVE_BALANCE in $consultaActivosClienteResponseRecord/ASSET_RESERVE_BALANCE
                            return
                                <ns0:ASSET_RESERVE_BALANCE>{ data($ASSET_RESERVE_BALANCE) }</ns0:ASSET_RESERVE_BALANCE>
                        }
                        {
                            for $ASSET_LOCKED_BALANCE in $consultaActivosClienteResponseRecord/ASSET_LOCKED_BALANCE
                            return
                                <ns0:ASSET_LOCKED_BALANCE>{ data($ASSET_LOCKED_BALANCE) }</ns0:ASSET_LOCKED_BALANCE>
                        }
                        {
                            for $ASSET_VISA_FLOATING_BALANCE in $consultaActivosClienteResponseRecord/ASSET_VISA_FLOATING_BALANCE
                            return
                                <ns0:ASSET_VISA_FLOATING_BALANCE>{ data($ASSET_VISA_FLOATING_BALANCE) }</ns0:ASSET_VISA_FLOATING_BALANCE>
                        }
                        {
                            for $ASSET_AVAILABLE_BALANCE in $consultaActivosClienteResponseRecord/ASSET_AVAILABLE_BALANCE
                            return
                                <ns0:ASSET_AVAILABLE_BALANCE>{ data($ASSET_AVAILABLE_BALANCE) }</ns0:ASSET_AVAILABLE_BALANCE>
                        }
                        {
                            for $ASSET_SOURCE_BANK in $consultaActivosClienteResponseRecord/ASSET_SOURCE_BANK
                            return
                                <ns0:ASSET_SOURCE_BANK>{ data($ASSET_SOURCE_BANK) }</ns0:ASSET_SOURCE_BANK>
                        }
                        {
                            for $ASSET_PRODUCT_TYPE in $consultaActivosClienteResponseRecord/ASSET_PRODUCT_TYPE
                            return
                                <ns0:ASSET_PRODUCT_TYPE>{ data($ASSET_PRODUCT_TYPE) }</ns0:ASSET_PRODUCT_TYPE>
                        }
                    </ns0:consultaActivosClienteResponseRecordType>
                    }
                </ns0:consultaActivosClienteCorrienteResponseType>
                )else()
                  }
                  {
                if (   $TypeSerch='ALL' or $TypeSerch='DEP'  ) then(
                <ns0:consultaActivosClienteDepositosResponseType>
                    {
                        for $SUCCESS_INDICATOR in $consultaActivosClienteResponseOUT/ns1:consultaActivosClienteDepositosResponseType/SUCCESS_INDICATOR
                        return
                            <ns0:SUCCESS_INDICATOR>{ data($SUCCESS_INDICATOR) }</ns0:SUCCESS_INDICATOR>
                    }
                    {
                    for $consultaActivosClienteResponseRecord in $consultaActivosClienteResponseOUT/ns1:consultaActivosClienteDepositosResponseType/ns1:consultaActivosClienteResponseRecordType
                         return   
                    <ns0:consultaActivosClienteResponseRecordType>
                       {
                            for $ASSET_TYPE in $consultaActivosClienteResponseRecord/ASSET_TYPE
                            return
                                <ns0:ASSET_TYPE>{ data($ASSET_TYPE) }</ns0:ASSET_TYPE>
                        }
                        {
                            for $ASSET_NUMBER in $consultaActivosClienteResponseRecord/ASSET_NUMBER
                            return
                                <ns0:ASSET_NUMBER>{ data($ASSET_NUMBER) }</ns0:ASSET_NUMBER>
                        }
                        {
                            for $ASSET_NAME in $consultaActivosClienteResponseRecord/ASSET_NAME
                            return
                                <ns0:ASSET_NAME>{ data($ASSET_NAME) }</ns0:ASSET_NAME>
                        }
                        {
                            for $ASSET_CURRENCY in $consultaActivosClienteResponseRecord/ASSET_CURRENCY
                            return
                                <ns0:ASSET_CURRENCY>{ data($ASSET_CURRENCY) }</ns0:ASSET_CURRENCY>
                        }
                        {
                            for $ASSET_TOTAL_BALANCE in $consultaActivosClienteResponseRecord/ASSET_TOTAL_BALANCE
                            return
                                <ns0:ASSET_TOTAL_BALANCE>{ data($ASSET_TOTAL_BALANCE) }</ns0:ASSET_TOTAL_BALANCE>
                        }
                        {
                            for $ASSET_RESERVE_BALANCE in $consultaActivosClienteResponseRecord/ASSET_RESERVE_BALANCE
                            return
                                <ns0:ASSET_RESERVE_BALANCE>{ data($ASSET_RESERVE_BALANCE) }</ns0:ASSET_RESERVE_BALANCE>
                        }
                        {
                            for $ASSET_LOCKED_BALANCE in $consultaActivosClienteResponseRecord/ASSET_LOCKED_BALANCE
                            return
                                <ns0:ASSET_LOCKED_BALANCE>{ data($ASSET_LOCKED_BALANCE) }</ns0:ASSET_LOCKED_BALANCE>
                        }
                        {
                            for $ASSET_VISA_FLOATING_BALANCE in $consultaActivosClienteResponseRecord/ASSET_VISA_FLOATING_BALANCE
                            return
                                <ns0:ASSET_VISA_FLOATING_BALANCE>{ data($ASSET_VISA_FLOATING_BALANCE) }</ns0:ASSET_VISA_FLOATING_BALANCE>
                        }
                        {
                            for $ASSET_AVAILABLE_BALANCE in $consultaActivosClienteResponseRecord/ASSET_AVAILABLE_BALANCE
                            return
                                <ns0:ASSET_AVAILABLE_BALANCE>{ data($ASSET_AVAILABLE_BALANCE) }</ns0:ASSET_AVAILABLE_BALANCE>
                        }
                        {
                            for $ASSET_SOURCE_BANK in $consultaActivosClienteResponseRecord/ASSET_SOURCE_BANK
                            return
                                <ns0:ASSET_SOURCE_BANK>{ data($ASSET_SOURCE_BANK) }</ns0:ASSET_SOURCE_BANK>
                        }
                        {
                            for $ASSET_PRODUCT_TYPE in $consultaActivosClienteResponseRecord/ASSET_PRODUCT_TYPE
                            return
                                <ns0:ASSET_PRODUCT_TYPE>{ data($ASSET_PRODUCT_TYPE) }</ns0:ASSET_PRODUCT_TYPE>
                        }
                    </ns0:consultaActivosClienteResponseRecordType>
                    }
                </ns0:consultaActivosClienteDepositosResponseType>
                )else()
                  }
                {
                if (   $TypeSerch='ALL' or $TypeSerch='FPC'  ) then(
                <ns0:consultaActivosClientePensionesResponseType>
                    {
                        for $SUCCESS_INDICATOR in $consultaActivosClienteResponseOUT/ns1:consultaActivosClientePensionesResponseType/SUCCESS_INDICATOR
                        return
                            <ns0:SUCCESS_INDICATOR>{ data($SUCCESS_INDICATOR) }</ns0:SUCCESS_INDICATOR>
                    }
                    {
                    for $consultaActivosClienteResponseRecord in $consultaActivosClienteResponseOUT/ns1:consultaActivosClientePensionesResponseType/ns1:consultaActivosClienteResponseRecordType
                         return
                    <ns0:consultaActivosClienteResponseRecordType>
                       {
                            for $ASSET_TYPE in $consultaActivosClienteResponseRecord/ASSET_TYPE
                            return
                                <ns0:ASSET_TYPE>{ data($ASSET_TYPE) }</ns0:ASSET_TYPE>
                        }
                        {
                            for $ASSET_NUMBER in $consultaActivosClienteResponseRecord/ASSET_NUMBER
                            return
                                <ns0:ASSET_NUMBER>{ data($ASSET_NUMBER) }</ns0:ASSET_NUMBER>
                        }
                        {
                            for $ASSET_NAME in $consultaActivosClienteResponseRecord/ASSET_NAME
                            return
                                <ns0:ASSET_NAME>{ data($ASSET_NAME) }</ns0:ASSET_NAME>
                        }
                        {
                            for $ASSET_CURRENCY in $consultaActivosClienteResponseRecord/ASSET_CURRENCY
                            return
                                <ns0:ASSET_CURRENCY>{ data($ASSET_CURRENCY) }</ns0:ASSET_CURRENCY>
                        }
                        {
                            for $ASSET_TOTAL_BALANCE in $consultaActivosClienteResponseRecord/ASSET_TOTAL_BALANCE
                            return
                                <ns0:ASSET_TOTAL_BALANCE>{ data($ASSET_TOTAL_BALANCE) }</ns0:ASSET_TOTAL_BALANCE>
                        }
                        {
                            for $ASSET_RESERVE_BALANCE in $consultaActivosClienteResponseRecord/ASSET_RESERVE_BALANCE
                            return
                                <ns0:ASSET_RESERVE_BALANCE>{ data($ASSET_RESERVE_BALANCE) }</ns0:ASSET_RESERVE_BALANCE>
                        }
                        {
                            for $ASSET_LOCKED_BALANCE in $consultaActivosClienteResponseRecord/ASSET_LOCKED_BALANCE
                            return
                                <ns0:ASSET_LOCKED_BALANCE>{ data($ASSET_LOCKED_BALANCE) }</ns0:ASSET_LOCKED_BALANCE>
                        }
                        {
                            for $ASSET_VISA_FLOATING_BALANCE in $consultaActivosClienteResponseRecord/ASSET_VISA_FLOATING_BALANCE
                            return
                                <ns0:ASSET_VISA_FLOATING_BALANCE>{ data($ASSET_VISA_FLOATING_BALANCE) }</ns0:ASSET_VISA_FLOATING_BALANCE>
                        }
                        {
                            for $ASSET_AVAILABLE_BALANCE in $consultaActivosClienteResponseRecord/ASSET_AVAILABLE_BALANCE
                            return
                                <ns0:ASSET_AVAILABLE_BALANCE>{ data($ASSET_AVAILABLE_BALANCE) }</ns0:ASSET_AVAILABLE_BALANCE>
                        }
                        {
                            for $ASSET_SOURCE_BANK in $consultaActivosClienteResponseRecord/ASSET_SOURCE_BANK
                            return
                                <ns0:ASSET_SOURCE_BANK>{ data($ASSET_SOURCE_BANK) }</ns0:ASSET_SOURCE_BANK>
                        }
                        {
                            for $ASSET_PRODUCT_TYPE in $consultaActivosClienteResponseRecord/ASSET_PRODUCT_TYPE
                            return
                                <ns0:ASSET_PRODUCT_TYPE>{ data($ASSET_PRODUCT_TYPE) }</ns0:ASSET_PRODUCT_TYPE>
                        }
                    </ns0:consultaActivosClienteResponseRecordType>
                      }
                </ns0:consultaActivosClientePensionesResponseType>
                )else()
                  }
            </ns0:ASSET>
          </ns0:ASSETS_INFORMATION>
        </ns0:sjConsultaActivosPasivosClienteResponse>
};

declare variable $consultaActivosClienteResponseOUT as element(ns1:consultaActivosClienteResponse) external;
declare variable $TypeSerch as xs:string external;

xf:ConsultaActivosClienteOUT($consultaActivosClienteResponseOUT,
$TypeSerch)

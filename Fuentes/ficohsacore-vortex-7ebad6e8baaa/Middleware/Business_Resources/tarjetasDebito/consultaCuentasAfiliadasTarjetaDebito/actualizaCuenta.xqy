xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCuentasAfiliadasTarjetaDebitoResponse" element="ns0:consultaCuentasAfiliadasTarjetaDebitoResponse" location="consultaCuentasAfiliadasTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCuentasAfiliadasTarjetaDebitoResponse" location="consultaCuentasAfiliadasTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasAfiliadasTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/consultaCuentasAfiliadasTarjetaDebito/actualizaCuenta/";

declare function xf:actualizaCuenta($consultaCuentasAfiliadasTarjetaDebitoResponse as element(ns0:consultaCuentasAfiliadasTarjetaDebitoResponse),
    $newAccount as xs:string,
    $position as xs:int)
    as element(ns0:consultaCuentasAfiliadasTarjetaDebitoResponse) {
        <ns0:consultaCuentasAfiliadasTarjetaDebitoResponse>
            {
                for $consultaCuentasAfiliadasTarjetaDebitoResponseType in $consultaCuentasAfiliadasTarjetaDebitoResponse/ns0:consultaCuentasAfiliadasTarjetaDebitoResponseType
                return
                    <ns0:consultaCuentasAfiliadasTarjetaDebitoResponseType>
                        {
                            for $consultaCuentasAfiliadasTarjetaDebitoResponseRecordType at $i in $consultaCuentasAfiliadasTarjetaDebitoResponseType/ns0:consultaCuentasAfiliadasTarjetaDebitoResponseRecordType
                            return
                                <ns0:consultaCuentasAfiliadasTarjetaDebitoResponseRecordType>
                                    {
                                    	if ($i = $position) then (
                                    		<ACCOUNT_NUMBER>{ $newAccount }</ACCOUNT_NUMBER>
                                    	) else (
                                    		<ACCOUNT_NUMBER>{ data($consultaCuentasAfiliadasTarjetaDebitoResponseRecordType/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                                    	)
                                    }
                                    {
                                        for $ACCOUNT_RANK in $consultaCuentasAfiliadasTarjetaDebitoResponseRecordType/ACCOUNT_RANK
                                        return
                                            <ACCOUNT_RANK>{ data($ACCOUNT_RANK) }</ACCOUNT_RANK>
                                    }
                                    {
                                        for $CURRENCY in $consultaCuentasAfiliadasTarjetaDebitoResponseRecordType/CURRENCY
                                        return
                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                    }
                                </ns0:consultaCuentasAfiliadasTarjetaDebitoResponseRecordType>
                        }
                    </ns0:consultaCuentasAfiliadasTarjetaDebitoResponseType>
            }
        </ns0:consultaCuentasAfiliadasTarjetaDebitoResponse>
};

declare variable $consultaCuentasAfiliadasTarjetaDebitoResponse as element(ns0:consultaCuentasAfiliadasTarjetaDebitoResponse) external;
declare variable $newAccount as xs:string external;
declare variable $position as xs:int external;

xf:actualizaCuenta($consultaCuentasAfiliadasTarjetaDebitoResponse,
    $newAccount,
    $position)
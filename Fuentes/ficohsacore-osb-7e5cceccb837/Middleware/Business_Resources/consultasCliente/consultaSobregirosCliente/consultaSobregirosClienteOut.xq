(:: pragma bea:global-element-parameter parameter="$consultadesobregirosporclienteResponse" element="ns0:ConsultadesobregirosporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSobregirosClienteResponse" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaSobregirosCliente/consultaSobregirosClienteOut/";

declare function xf:consultaSobregirosClienteOut($consultadesobregirosporclienteResponse as element(ns0:ConsultadesobregirosporclienteResponse))
    as element(ns1:consultaSobregirosClienteResponse) {
        <ns1:consultaSobregirosClienteResponse>
            {
                for $gWSOVERDRAFTLIMITDetailType in $consultadesobregirosporclienteResponse/WSOVERDRAFTLIMITType[1]/gWSOVERDRAFTLIMITDetailType
                return
                    <ns1:consultaSobregirosClienteResponseType>
                        {
                            for $mWSOVERDRAFTLIMITDetailType in $gWSOVERDRAFTLIMITDetailType/mWSOVERDRAFTLIMITDetailType
                            return
                                <ns1:consultaSobregirosClienteResponseRecordType>
                                    {
                                        for $ACCOUNT in $mWSOVERDRAFTLIMITDetailType/ACCOUNT
                                        return
                                            <ACCOUNT_NUMBER>{ data($ACCOUNT) }</ACCOUNT_NUMBER>
                                    }
                                    {
                                        for $ACCOUNTNAME in $mWSOVERDRAFTLIMITDetailType/ACCOUNTNAME
                                        return
                                            <ACCOUNT_NAME>{ data($ACCOUNTNAME) }</ACCOUNT_NAME>
                                    }
                                    {
                                        for $CURRENCY in $mWSOVERDRAFTLIMITDetailType/CURRENCY
                                        return
                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                    }
                                    {
                                        for $TOTALOVERDRAFT in $mWSOVERDRAFTLIMITDetailType/TOTALOVERDRAFT
                                        return
                                            <OVERDRAFT_BALANCE>{ data($TOTALOVERDRAFT) }</OVERDRAFT_BALANCE>
                                    }
                                </ns1:consultaSobregirosClienteResponseRecordType>
                        }
                    </ns1:consultaSobregirosClienteResponseType>
            }
        </ns1:consultaSobregirosClienteResponse>
};

declare variable $consultadesobregirosporclienteResponse as element(ns0:ConsultadesobregirosporclienteResponse) external;

xf:consultaSobregirosClienteOut($consultadesobregirosporclienteResponse)
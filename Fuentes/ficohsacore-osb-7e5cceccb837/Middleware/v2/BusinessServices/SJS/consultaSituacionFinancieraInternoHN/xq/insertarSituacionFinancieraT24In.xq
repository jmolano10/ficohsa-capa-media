(:: pragma bea:global-element-parameter parameter="$consultaSituacionFinancieraResponse" element="ns0:ConsultaSituacionFinancieraResponse" location="../../../T24/consultaSituacionFinanciera/xsd/XMLSchema_-1839398308.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../INTFC/insertarSituacionFinanciera/xsd/insertarSituacionFinanciera_sp.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertarSituacionFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/insertarSituacionFinancieraT24In/";

declare function xf:insertarSituacionFinancieraT24In($consultaSituacionFinancieraResponse as element(ns0:ConsultaSituacionFinancieraResponse),
    $referenciaLlave as xs:string,
    $usuario as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_REFERENCIA_LLAVE>{ $referenciaLlave }</ns1:PV_REFERENCIA_LLAVE>
	            {
	                for $Region in $consultaSituacionFinancieraResponse/FICOECUSTACTPASPRODSWSType[1]/gFICOECUSTACTPASPRODSWSDetailType/mFICOECUSTACTPASPRODSWSDetailType[1]/Region
	                return
	                    <ns1:PV_REGION>{ data($Region) }</ns1:PV_REGION>
	            }
            <ns1:PV_USUARIO_SERVICIO>{ $usuario }</ns1:PV_USUARIO_SERVICIO>
            <ns1:PT_APLICACION_CORE>
            	{ 
            		for $detail in $consultaSituacionFinancieraResponse/FICOECUSTACTPASPRODSWSType[1]/gFICOECUSTACTPASPRODSWSDetailType/mFICOECUSTACTPASPRODSWSDetailType
            		return
            			for $i in 1 to count(fn:tokenize($detail/Currency, '!!'))
            			return
            				<ns1:PT_APLICACION_CORE_ITEM>T24</ns1:PT_APLICACION_CORE_ITEM>
            					
            	}
            </ns1:PT_APLICACION_CORE>
            <ns1:PT_ACTIVO_PASIVO>
            	{ 
            		for $detail in $consultaSituacionFinancieraResponse/FICOECUSTACTPASPRODSWSType[1]/gFICOECUSTACTPASPRODSWSDetailType/mFICOECUSTACTPASPRODSWSDetailType
            		return
            			for $i in 1 to count(fn:tokenize($detail/Currency, '!!'))
            			return
            				<ns1:PT_APLICACION_CORE_ITEM>{ fn:string($detail/Type/text()) }</ns1:PT_APLICACION_CORE_ITEM>
            					
            	}
            </ns1:PT_ACTIVO_PASIVO>
            <ns1:PT_TIPO_PRODUCTO>
            	{ 
            		for $detail in $consultaSituacionFinancieraResponse/FICOECUSTACTPASPRODSWSType[1]/gFICOECUSTACTPASPRODSWSDetailType/mFICOECUSTACTPASPRODSWSDetailType
            		return
            			for $i in 1 to count(fn:tokenize($detail/Currency, '!!'))
            			return
            				<ns1:PT_APLICACION_CORE_ITEM>{ fn:string($detail/ProductType/text()) }</ns1:PT_APLICACION_CORE_ITEM>
            					
            	}
            </ns1:PT_TIPO_PRODUCTO>
            <ns1:PT_CODIGO_MONEDA>
            	{ 
            		for $detail in $consultaSituacionFinancieraResponse/FICOECUSTACTPASPRODSWSType[1]/gFICOECUSTACTPASPRODSWSDetailType/mFICOECUSTACTPASPRODSWSDetailType
            		return
            			for $currency in fn:tokenize($detail/Currency, '!!')
            			return
            				<ns1:PT_CODIGO_MONEDA_ITEM>{ fn:string($currency) }</ns1:PT_CODIGO_MONEDA_ITEM>
            					
            	}
            </ns1:PT_CODIGO_MONEDA>
            <ns1:PT_SALDO_DISPONIBLE>
            	{ 
            		for $detail in $consultaSituacionFinancieraResponse/FICOECUSTACTPASPRODSWSType[1]/gFICOECUSTACTPASPRODSWSDetailType/mFICOECUSTACTPASPRODSWSDetailType
            		return
            			for $availableBalance in fn:tokenize($detail/AvailableBalance, '!!')
            			return
            				<ns1:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($availableBalance) }</ns1:PT_SALDO_DISPONIBLE_ITEM>
            	}
            </ns1:PT_SALDO_DISPONIBLE>
            <ns1:PT_SALDO_TOTAL>
            	{ 
            		for $detail in $consultaSituacionFinancieraResponse/FICOECUSTACTPASPRODSWSType[1]/gFICOECUSTACTPASPRODSWSDetailType/mFICOECUSTACTPASPRODSWSDetailType
            		return
            			for $totalBalance in fn:tokenize($detail/TotalBalance, '!!')
            			return
            				<ns1:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($totalBalance) }</ns1:PT_SALDO_DISPONIBLE_ITEM>
            	}
            </ns1:PT_SALDO_TOTAL>
            <ns1:PT_SUCCESS_INDICADOR_IN>
            	{ 
            		let $successIndicator := fn:string($consultaSituacionFinancieraResponse/Status/successIndicator/text())
            		for $detail in $consultaSituacionFinancieraResponse/FICOECUSTACTPASPRODSWSType[1]/gFICOECUSTACTPASPRODSWSDetailType/mFICOECUSTACTPASPRODSWSDetailType
            		return
            			for $i in 1 to count(fn:tokenize($detail/Currency, '!!'))
            			return
            				<ns1:PT_APLICACION_CORE_ITEM>{ $successIndicator }</ns1:PT_APLICACION_CORE_ITEM>
            					
            	}
            </ns1:PT_SUCCESS_INDICADOR_IN>
            <ns1:PT_DESCRIPCION_MENSAJE>
            	{ 
            		let $messages := fn:string-join($consultaSituacionFinancieraResponse/Status/messages, '. ')
            		for $detail in $consultaSituacionFinancieraResponse/FICOECUSTACTPASPRODSWSType[1]/gFICOECUSTACTPASPRODSWSDetailType/mFICOECUSTACTPASPRODSWSDetailType
            		return
            			for $i in 1 to count(fn:tokenize($detail/Currency, '!!'))
            			return
            				<ns1:PT_DESCRIPCION_MENSAJE_ITEM>{ $messages }</ns1:PT_DESCRIPCION_MENSAJE_ITEM>
            					
            	}
            </ns1:PT_DESCRIPCION_MENSAJE>
        </ns1:InputParameters>
};

declare variable $consultaSituacionFinancieraResponse as element(ns0:ConsultaSituacionFinancieraResponse) external;
declare variable $referenciaLlave as xs:string external;
declare variable $usuario as xs:string external;

xf:insertarSituacionFinancieraT24In($consultaSituacionFinancieraResponse,
    $referenciaLlave,
    $usuario)

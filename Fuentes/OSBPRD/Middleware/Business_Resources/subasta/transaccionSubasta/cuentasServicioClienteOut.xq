(:: pragma bea:global-element-parameter parameter="$cuentasdeservicioporclienteResponse" element="ns0:CuentasdeservicioporclienteResponse" location="../../consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/transaccionSubasta/cuentasServicioClienteOut/";

declare function xf:cuentasServicioClienteOut($cuentasdeservicioporclienteResponse as element(ns0:CuentasdeservicioporclienteResponse))
    as xs:string? {
    	for $moneda at $i in fn:tokenize($cuentasdeservicioporclienteResponse/WSFICOLINKSERVICEACCTType[1]/gWSFICOLINKSERVICEACCTDetailType/mWSFICOLINKSERVICEACCTDetailType[1]/AUCACCTCCY, "\|\|") 
        return
        	if ($moneda = "HNL") then (
        		fn:string(fn:tokenize($cuentasdeservicioporclienteResponse/WSFICOLINKSERVICEACCTType[1]/gWSFICOLINKSERVICEACCTDetailType/mWSFICOLINKSERVICEACCTDetailType[1]/AUCACCTID, "\|\|")[$i])
        	) else ()
        
};

declare variable $cuentasdeservicioporclienteResponse as element(ns0:CuentasdeservicioporclienteResponse) external;

xf:cuentasServicioClienteOut($cuentasdeservicioporclienteResponse)
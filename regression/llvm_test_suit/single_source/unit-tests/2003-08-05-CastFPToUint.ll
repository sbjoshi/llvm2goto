; ModuleID = '2003-08-05-CastFPToUint.c'
source_filename = "2003-08-05-CastFPToUint.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main(i32 %argc, i8** %argv) #0 !dbg !12 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %DC = alloca double, align 8
  %DS = alloca double, align 8
  %DI = alloca double, align 8
  %uc = alloca i8, align 1
  %us = alloca i16, align 2
  %ui = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !19, metadata !20), !dbg !21
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !22, metadata !20), !dbg !23
  call void @llvm.dbg.declare(metadata double* %DC, metadata !24, metadata !20), !dbg !25
  %call = call double @getDC(), !dbg !26
  store double %call, double* %DC, align 8, !dbg !25
  call void @llvm.dbg.declare(metadata double* %DS, metadata !27, metadata !20), !dbg !28
  %call1 = call double @getDS(), !dbg !29
  store double %call1, double* %DS, align 8, !dbg !28
  call void @llvm.dbg.declare(metadata double* %DI, metadata !30, metadata !20), !dbg !31
  %call2 = call double @getDI(), !dbg !32
  store double %call2, double* %DI, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata i8* %uc, metadata !33, metadata !20), !dbg !34
  %0 = load double, double* %DC, align 8, !dbg !35
  %conv = fptoui double %0 to i8, !dbg !36
  store i8 %conv, i8* %uc, align 1, !dbg !34
  call void @llvm.dbg.declare(metadata i16* %us, metadata !37, metadata !20), !dbg !38
  %1 = load double, double* %DS, align 8, !dbg !39
  %conv3 = fptoui double %1 to i16, !dbg !40
  store i16 %conv3, i16* %us, align 2, !dbg !38
  call void @llvm.dbg.declare(metadata i32* %ui, metadata !41, metadata !20), !dbg !42
  %2 = load double, double* %DI, align 8, !dbg !43
  %conv4 = fptoui double %2 to i32, !dbg !44
  store i32 %conv4, i32* %ui, align 4, !dbg !42
  %3 = load double, double* %DC, align 8, !dbg !45
  %cmp = fcmp oeq double %3, 2.400000e+02, !dbg !46
  %conv5 = zext i1 %cmp to i32, !dbg !46
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv5), !dbg !47
  %4 = load double, double* %DS, align 8, !dbg !48
  %cmp7 = fcmp oeq double %4, 6.552000e+04, !dbg !49
  %conv8 = zext i1 %cmp7 to i32, !dbg !49
  %call9 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv8), !dbg !50
  %5 = load double, double* %DI, align 8, !dbg !51
  %cmp10 = fcmp oeq double %5, 0x41EFFFFFFE000000, !dbg !52
  %conv11 = zext i1 %cmp10 to i32, !dbg !52
  %call12 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv11), !dbg !53
  %6 = load i8, i8* %uc, align 1, !dbg !54
  %conv13 = zext i8 %6 to i32, !dbg !54
  %cmp14 = icmp eq i32 %conv13, 240, !dbg !55
  %conv15 = zext i1 %cmp14 to i32, !dbg !55
  %call16 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv15), !dbg !56
  %7 = load i16, i16* %us, align 2, !dbg !57
  %conv17 = zext i16 %7 to i32, !dbg !57
  %cmp18 = icmp eq i32 %conv17, 65520, !dbg !58
  %conv19 = zext i1 %cmp18 to i32, !dbg !58
  %call20 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv19), !dbg !59
  %8 = load i32, i32* %ui, align 4, !dbg !60
  %conv21 = zext i32 %8 to i64, !dbg !60
  %cmp22 = icmp eq i64 %conv21, 4294967280, !dbg !61
  %conv23 = zext i1 %cmp22 to i32, !dbg !61
  %call24 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv23), !dbg !62
  ret i32 0, !dbg !63
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal double @getDC() #0 !dbg !64 {
entry:
  ret double 2.400000e+02, !dbg !67
}

; Function Attrs: noinline nounwind optnone uwtable
define internal double @getDS() #0 !dbg !68 {
entry:
  ret double 6.552000e+04, !dbg !69
}

; Function Attrs: noinline nounwind optnone uwtable
define internal double @getDI() #0 !dbg !70 {
entry:
  ret double 0x41EFFFFFFE000000, !dbg !71
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!8, !9, !10}
!llvm.ident = !{!11}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "2003-08-05-CastFPToUint.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{!4, !5, !6, !7}
!4 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!5 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!6 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!7 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!8 = !{i32 2, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!12 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !13, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !15, !16}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!19 = !DILocalVariable(name: "argc", arg: 1, scope: !12, file: !1, line: 13, type: !15)
!20 = !DIExpression()
!21 = !DILocation(line: 13, column: 10, scope: !12)
!22 = !DILocalVariable(name: "argv", arg: 2, scope: !12, file: !1, line: 13, type: !16)
!23 = !DILocation(line: 13, column: 23, scope: !12)
!24 = !DILocalVariable(name: "DC", scope: !12, file: !1, line: 14, type: !7)
!25 = !DILocation(line: 14, column: 10, scope: !12)
!26 = !DILocation(line: 14, column: 15, scope: !12)
!27 = !DILocalVariable(name: "DS", scope: !12, file: !1, line: 15, type: !7)
!28 = !DILocation(line: 15, column: 10, scope: !12)
!29 = !DILocation(line: 15, column: 15, scope: !12)
!30 = !DILocalVariable(name: "DI", scope: !12, file: !1, line: 16, type: !7)
!31 = !DILocation(line: 16, column: 10, scope: !12)
!32 = !DILocation(line: 16, column: 15, scope: !12)
!33 = !DILocalVariable(name: "uc", scope: !12, file: !1, line: 17, type: !4)
!34 = !DILocation(line: 17, column: 18, scope: !12)
!35 = !DILocation(line: 17, column: 40, scope: !12)
!36 = !DILocation(line: 17, column: 23, scope: !12)
!37 = !DILocalVariable(name: "us", scope: !12, file: !1, line: 18, type: !5)
!38 = !DILocation(line: 18, column: 18, scope: !12)
!39 = !DILocation(line: 18, column: 40, scope: !12)
!40 = !DILocation(line: 18, column: 23, scope: !12)
!41 = !DILocalVariable(name: "ui", scope: !12, file: !1, line: 19, type: !6)
!42 = !DILocation(line: 19, column: 18, scope: !12)
!43 = !DILocation(line: 19, column: 40, scope: !12)
!44 = !DILocation(line: 19, column: 23, scope: !12)
!45 = !DILocation(line: 22, column: 10, scope: !12)
!46 = !DILocation(line: 22, column: 13, scope: !12)
!47 = !DILocation(line: 22, column: 3, scope: !12)
!48 = !DILocation(line: 23, column: 10, scope: !12)
!49 = !DILocation(line: 23, column: 13, scope: !12)
!50 = !DILocation(line: 23, column: 3, scope: !12)
!51 = !DILocation(line: 24, column: 10, scope: !12)
!52 = !DILocation(line: 24, column: 13, scope: !12)
!53 = !DILocation(line: 24, column: 3, scope: !12)
!54 = !DILocation(line: 25, column: 10, scope: !12)
!55 = !DILocation(line: 25, column: 13, scope: !12)
!56 = !DILocation(line: 25, column: 3, scope: !12)
!57 = !DILocation(line: 26, column: 10, scope: !12)
!58 = !DILocation(line: 26, column: 13, scope: !12)
!59 = !DILocation(line: 26, column: 3, scope: !12)
!60 = !DILocation(line: 27, column: 10, scope: !12)
!61 = !DILocation(line: 27, column: 13, scope: !12)
!62 = !DILocation(line: 27, column: 3, scope: !12)
!63 = !DILocation(line: 28, column: 3, scope: !12)
!64 = distinct !DISubprogram(name: "getDC", scope: !1, file: !1, line: 31, type: !65, isLocal: true, isDefinition: true, scopeLine: 31, isOptimized: false, unit: !0, variables: !2)
!65 = !DISubroutineType(types: !66)
!66 = !{!7}
!67 = !DILocation(line: 31, column: 25, scope: !64)
!68 = distinct !DISubprogram(name: "getDS", scope: !1, file: !1, line: 32, type: !65, isLocal: true, isDefinition: true, scopeLine: 32, isOptimized: false, unit: !0, variables: !2)
!69 = !DILocation(line: 32, column: 25, scope: !68)
!70 = distinct !DISubprogram(name: "getDI", scope: !1, file: !1, line: 33, type: !65, isLocal: true, isDefinition: true, scopeLine: 33, isOptimized: false, unit: !0, variables: !2)
!71 = !DILocation(line: 33, column: 25, scope: !70)

; ModuleID = '2003-07-10-SignConversions.c'
source_filename = "2003-07-10-SignConversions.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define zeroext i8 @getUC() #0 !dbg !12 {
entry:
  ret i8 -128, !dbg !15
}

; Function Attrs: noinline nounwind optnone uwtable
define signext i8 @getSC() #0 !dbg !16 {
entry:
  ret i8 -128, !dbg !19
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !20 {
entry:
  %retval = alloca i32, align 4
  %SC80 = alloca i8, align 1
  %UC80 = alloca i8, align 1
  %us = alloca i16, align 2
  %us2 = alloca i16, align 2
  %s = alloca i16, align 2
  %s2 = alloca i16, align 2
  %uc = alloca i8, align 1
  %uc2 = alloca i8, align 1
  %sc = alloca i8, align 1
  %sc2 = alloca i8, align 1
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8* %SC80, metadata !24, metadata !25), !dbg !26
  %call = call signext i8 @getSC(), !dbg !27
  store i8 %call, i8* %SC80, align 1, !dbg !26
  call void @llvm.dbg.declare(metadata i8* %UC80, metadata !28, metadata !25), !dbg !29
  %call1 = call zeroext i8 @getUC(), !dbg !30
  store i8 %call1, i8* %UC80, align 1, !dbg !29
  call void @llvm.dbg.declare(metadata i16* %us, metadata !31, metadata !25), !dbg !32
  %0 = load i8, i8* %SC80, align 1, !dbg !33
  %conv = sext i8 %0 to i16, !dbg !34
  store i16 %conv, i16* %us, align 2, !dbg !32
  call void @llvm.dbg.declare(metadata i16* %us2, metadata !35, metadata !25), !dbg !36
  %1 = load i8, i8* %UC80, align 1, !dbg !37
  %conv2 = zext i8 %1 to i16, !dbg !38
  store i16 %conv2, i16* %us2, align 2, !dbg !36
  call void @llvm.dbg.declare(metadata i16* %s, metadata !39, metadata !25), !dbg !40
  %2 = load i8, i8* %SC80, align 1, !dbg !41
  %conv3 = sext i8 %2 to i16, !dbg !42
  store i16 %conv3, i16* %s, align 2, !dbg !40
  call void @llvm.dbg.declare(metadata i16* %s2, metadata !43, metadata !25), !dbg !44
  %3 = load i8, i8* %UC80, align 1, !dbg !45
  %conv4 = zext i8 %3 to i16, !dbg !46
  store i16 %conv4, i16* %s2, align 2, !dbg !44
  %4 = load i16, i16* %us, align 2, !dbg !47
  %conv5 = zext i16 %4 to i32, !dbg !47
  %cmp = icmp eq i32 %conv5, -65408, !dbg !48
  %conv6 = zext i1 %cmp to i32, !dbg !48
  %call7 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !49
  %5 = load i16, i16* %us2, align 2, !dbg !50
  %conv8 = zext i16 %5 to i32, !dbg !50
  %cmp9 = icmp eq i32 %conv8, 128, !dbg !51
  %conv10 = zext i1 %cmp9 to i32, !dbg !51
  %call11 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv10), !dbg !52
  %6 = load i16, i16* %s, align 2, !dbg !53
  %conv12 = sext i16 %6 to i32, !dbg !53
  %cmp13 = icmp eq i32 %conv12, -128, !dbg !54
  %conv14 = zext i1 %cmp13 to i32, !dbg !54
  %call15 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv14), !dbg !55
  %7 = load i16, i16* %s2, align 2, !dbg !56
  %conv16 = sext i16 %7 to i32, !dbg !56
  %cmp17 = icmp eq i32 %conv16, 128, !dbg !57
  %conv18 = zext i1 %cmp17 to i32, !dbg !57
  %call19 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv18), !dbg !58
  call void @llvm.dbg.declare(metadata i8* %uc, metadata !59, metadata !25), !dbg !60
  %8 = load i8, i8* %SC80, align 1, !dbg !61
  store i8 %8, i8* %uc, align 1, !dbg !60
  call void @llvm.dbg.declare(metadata i8* %uc2, metadata !62, metadata !25), !dbg !63
  %9 = load i8, i8* %UC80, align 1, !dbg !64
  store i8 %9, i8* %uc2, align 1, !dbg !63
  call void @llvm.dbg.declare(metadata i8* %sc, metadata !65, metadata !25), !dbg !66
  %10 = load i8, i8* %SC80, align 1, !dbg !67
  store i8 %10, i8* %sc, align 1, !dbg !66
  call void @llvm.dbg.declare(metadata i8* %sc2, metadata !68, metadata !25), !dbg !69
  %11 = load i8, i8* %UC80, align 1, !dbg !70
  store i8 %11, i8* %sc2, align 1, !dbg !69
  %12 = load i8, i8* %uc, align 1, !dbg !71
  %conv20 = zext i8 %12 to i32, !dbg !71
  %cmp21 = icmp eq i32 %conv20, 128, !dbg !72
  %conv22 = zext i1 %cmp21 to i32, !dbg !72
  %call23 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv22), !dbg !73
  %13 = load i8, i8* %uc2, align 1, !dbg !74
  %conv24 = zext i8 %13 to i32, !dbg !74
  %cmp25 = icmp eq i32 %conv24, 128, !dbg !75
  %conv26 = zext i1 %cmp25 to i32, !dbg !75
  %call27 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv26), !dbg !76
  %14 = load i8, i8* %sc, align 1, !dbg !77
  %conv28 = sext i8 %14 to i32, !dbg !77
  %cmp29 = icmp eq i32 %conv28, -128, !dbg !78
  %conv30 = zext i1 %cmp29 to i32, !dbg !78
  %call31 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv30), !dbg !79
  %15 = load i8, i8* %sc2, align 1, !dbg !80
  %conv32 = sext i8 %15 to i32, !dbg !80
  %cmp33 = icmp eq i32 %conv32, -128, !dbg !81
  %conv34 = zext i1 %cmp33 to i32, !dbg !81
  %call35 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv34), !dbg !82
  ret i32 0, !dbg !83
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!8, !9, !10}
!llvm.ident = !{!11}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "2003-07-10-SignConversions.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{!4, !5, !6, !7}
!4 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!5 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!6 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!7 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!8 = !{i32 2, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!12 = distinct !DISubprogram(name: "getUC", scope: !1, file: !1, line: 7, type: !13, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!13 = !DISubroutineType(types: !14)
!14 = !{!6}
!15 = !DILocation(line: 7, column: 25, scope: !12)
!16 = distinct !DISubprogram(name: "getSC", scope: !1, file: !1, line: 9, type: !17, isLocal: false, isDefinition: true, scopeLine: 9, isOptimized: false, unit: !0, variables: !2)
!17 = !DISubroutineType(types: !18)
!18 = !{!7}
!19 = !DILocation(line: 9, column: 25, scope: !16)
!20 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !21, isLocal: false, isDefinition: true, scopeLine: 12, isOptimized: false, unit: !0, variables: !2)
!21 = !DISubroutineType(types: !22)
!22 = !{!23}
!23 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!24 = !DILocalVariable(name: "SC80", scope: !20, file: !1, line: 13, type: !7)
!25 = !DIExpression()
!26 = !DILocation(line: 13, column: 18, scope: !20)
!27 = !DILocation(line: 13, column: 25, scope: !20)
!28 = !DILocalVariable(name: "UC80", scope: !20, file: !1, line: 14, type: !6)
!29 = !DILocation(line: 14, column: 18, scope: !20)
!30 = !DILocation(line: 14, column: 25, scope: !20)
!31 = !DILocalVariable(name: "us", scope: !20, file: !1, line: 17, type: !4)
!32 = !DILocation(line: 17, column: 18, scope: !20)
!33 = !DILocation(line: 17, column: 41, scope: !20)
!34 = !DILocation(line: 17, column: 24, scope: !20)
!35 = !DILocalVariable(name: "us2", scope: !20, file: !1, line: 18, type: !4)
!36 = !DILocation(line: 18, column: 18, scope: !20)
!37 = !DILocation(line: 18, column: 41, scope: !20)
!38 = !DILocation(line: 18, column: 24, scope: !20)
!39 = !DILocalVariable(name: "s", scope: !20, file: !1, line: 19, type: !5)
!40 = !DILocation(line: 19, column: 19, scope: !20)
!41 = !DILocation(line: 19, column: 41, scope: !20)
!42 = !DILocation(line: 19, column: 24, scope: !20)
!43 = !DILocalVariable(name: "s2", scope: !20, file: !1, line: 20, type: !5)
!44 = !DILocation(line: 20, column: 19, scope: !20)
!45 = !DILocation(line: 20, column: 41, scope: !20)
!46 = !DILocation(line: 20, column: 24, scope: !20)
!47 = !DILocation(line: 23, column: 10, scope: !20)
!48 = !DILocation(line: 23, column: 13, scope: !20)
!49 = !DILocation(line: 23, column: 3, scope: !20)
!50 = !DILocation(line: 24, column: 10, scope: !20)
!51 = !DILocation(line: 24, column: 14, scope: !20)
!52 = !DILocation(line: 24, column: 3, scope: !20)
!53 = !DILocation(line: 25, column: 10, scope: !20)
!54 = !DILocation(line: 25, column: 12, scope: !20)
!55 = !DILocation(line: 25, column: 3, scope: !20)
!56 = !DILocation(line: 26, column: 10, scope: !20)
!57 = !DILocation(line: 26, column: 13, scope: !20)
!58 = !DILocation(line: 26, column: 3, scope: !20)
!59 = !DILocalVariable(name: "uc", scope: !20, file: !1, line: 29, type: !6)
!60 = !DILocation(line: 29, column: 18, scope: !20)
!61 = !DILocation(line: 29, column: 41, scope: !20)
!62 = !DILocalVariable(name: "uc2", scope: !20, file: !1, line: 30, type: !6)
!63 = !DILocation(line: 30, column: 18, scope: !20)
!64 = !DILocation(line: 30, column: 41, scope: !20)
!65 = !DILocalVariable(name: "sc", scope: !20, file: !1, line: 31, type: !7)
!66 = !DILocation(line: 31, column: 18, scope: !20)
!67 = !DILocation(line: 31, column: 41, scope: !20)
!68 = !DILocalVariable(name: "sc2", scope: !20, file: !1, line: 32, type: !7)
!69 = !DILocation(line: 32, column: 18, scope: !20)
!70 = !DILocation(line: 32, column: 41, scope: !20)
!71 = !DILocation(line: 35, column: 10, scope: !20)
!72 = !DILocation(line: 35, column: 13, scope: !20)
!73 = !DILocation(line: 35, column: 3, scope: !20)
!74 = !DILocation(line: 36, column: 10, scope: !20)
!75 = !DILocation(line: 36, column: 14, scope: !20)
!76 = !DILocation(line: 36, column: 3, scope: !20)
!77 = !DILocation(line: 37, column: 10, scope: !20)
!78 = !DILocation(line: 37, column: 13, scope: !20)
!79 = !DILocation(line: 37, column: 3, scope: !20)
!80 = !DILocation(line: 38, column: 10, scope: !20)
!81 = !DILocation(line: 38, column: 14, scope: !20)
!82 = !DILocation(line: 38, column: 3, scope: !20)
!83 = !DILocation(line: 39, column: 3, scope: !20)

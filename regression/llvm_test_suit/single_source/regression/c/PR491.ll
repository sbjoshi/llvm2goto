; ModuleID = 'PR491.c'
source_filename = "PR491.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.anon = type { i64 }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @test(i32 %r) #0 !dbg !7 {
entry:
  %r.addr = alloca i32, align 4
  %u = alloca %union.anon, align 8
  store i32 %r, i32* %r.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %r.addr, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.declare(metadata %union.anon* %u, metadata !14, metadata !12), !dbg !24
  %l = bitcast %union.anon* %u to i64*, !dbg !25
  store i64 0, i64* %l, align 8, !dbg !26
  %c = bitcast %union.anon* %u to [8 x i8]*, !dbg !27
  %arrayidx = getelementptr inbounds [8 x i8], [8 x i8]* %c, i64 0, i64 0, !dbg !28
  store i8 -128, i8* %arrayidx, align 8, !dbg !29
  %l1 = bitcast %union.anon* %u to i64*, !dbg !30
  %0 = load i64, i64* %l1, align 8, !dbg !30
  %cmp = icmp eq i64 %0, 128, !dbg !31
  %conv = zext i1 %cmp to i32, !dbg !31
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !32
  %1 = load i32, i32* %r.addr, align 4, !dbg !33
  %and = and i32 %1, %call, !dbg !33
  store i32 %and, i32* %r.addr, align 4, !dbg !33
  %l2 = bitcast %union.anon* %u to i64*, !dbg !34
  store i64 0, i64* %l2, align 8, !dbg !35
  %c3 = bitcast %union.anon* %u to [8 x i8]*, !dbg !36
  %arrayidx4 = getelementptr inbounds [8 x i8], [8 x i8]* %c3, i64 0, i64 7, !dbg !37
  store i8 -128, i8* %arrayidx4, align 1, !dbg !38
  %l5 = bitcast %union.anon* %u to i64*, !dbg !39
  %2 = load i64, i64* %l5, align 8, !dbg !39
  %cmp6 = icmp slt i64 %2, 0, !dbg !40
  %conv7 = zext i1 %cmp6 to i32, !dbg !40
  %call8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv7), !dbg !41
  %3 = load i32, i32* %r.addr, align 4, !dbg !42
  %and9 = and i32 %3, %call8, !dbg !42
  store i32 %and9, i32* %r.addr, align 4, !dbg !42
  %4 = load i32, i32* %r.addr, align 4, !dbg !43
  ret i32 %4, !dbg !44
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !45 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @test(i32 1), !dbg !48
  %cmp = icmp ne i32 %call, 1, !dbg !49
  %conv = zext i1 %cmp to i32, !dbg !49
  ret i32 %conv, !dbg !50
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "PR491.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "r", arg: 1, scope: !7, file: !1, line: 10, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 10, column: 14, scope: !7)
!14 = !DILocalVariable(name: "u", scope: !7, file: !1, line: 20, type: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !7, file: !1, line: 20, size: 64, elements: !16)
!16 = !{!17, !19}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "l", scope: !15, file: !1, line: 20, baseType: !18, size: 64)
!18 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !15, file: !1, line: 20, baseType: !20, size: 64)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 64, elements: !22)
!21 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!22 = !{!23}
!23 = !DISubrange(count: 8)
!24 = !DILocation(line: 20, column: 54, scope: !7)
!25 = !DILocation(line: 21, column: 7, scope: !7)
!26 = !DILocation(line: 21, column: 9, scope: !7)
!27 = !DILocation(line: 21, column: 16, scope: !7)
!28 = !DILocation(line: 21, column: 14, scope: !7)
!29 = !DILocation(line: 21, column: 21, scope: !7)
!30 = !DILocation(line: 22, column: 19, scope: !7)
!31 = !DILocation(line: 22, column: 21, scope: !7)
!32 = !DILocation(line: 22, column: 10, scope: !7)
!33 = !DILocation(line: 22, column: 7, scope: !7)
!34 = !DILocation(line: 23, column: 7, scope: !7)
!35 = !DILocation(line: 23, column: 9, scope: !7)
!36 = !DILocation(line: 23, column: 16, scope: !7)
!37 = !DILocation(line: 23, column: 14, scope: !7)
!38 = !DILocation(line: 23, column: 34, scope: !7)
!39 = !DILocation(line: 24, column: 19, scope: !7)
!40 = !DILocation(line: 24, column: 21, scope: !7)
!41 = !DILocation(line: 24, column: 10, scope: !7)
!42 = !DILocation(line: 24, column: 7, scope: !7)
!43 = !DILocation(line: 25, column: 12, scope: !7)
!44 = !DILocation(line: 25, column: 5, scope: !7)
!45 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 28, type: !46, isLocal: false, isDefinition: true, scopeLine: 28, isOptimized: false, unit: !0, variables: !2)
!46 = !DISubroutineType(types: !47)
!47 = !{!10}
!48 = !DILocation(line: 29, column: 12, scope: !45)
!49 = !DILocation(line: 29, column: 20, scope: !45)
!50 = !DILocation(line: 29, column: 5, scope: !45)

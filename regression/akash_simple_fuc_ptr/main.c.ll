; ModuleID = 'akash_simple_fuc_ptr/main.c'
source_filename = "akash_simple_fuc_ptr/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @f1(i32 %a, i32 %b) #0 !dbg !7 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !11, metadata !DIExpression()), !dbg !12
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !13, metadata !DIExpression()), !dbg !14
  %0 = load i32, i32* %a.addr, align 4, !dbg !15
  %1 = load i32, i32* %b.addr, align 4, !dbg !16
  %add = add nsw i32 %0, %1, !dbg !17
  ret i32 %add, !dbg !18
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @f2(i32 %a, i32 %b) #0 !dbg !19 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !22, metadata !DIExpression()), !dbg !23
  %0 = load i32, i32* %a.addr, align 4, !dbg !24
  %1 = load i32, i32* %b.addr, align 4, !dbg !25
  %sub = sub nsw i32 %0, %1, !dbg !26
  ret i32 %sub, !dbg !27
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !28 {
entry:
  %retval = alloca i32, align 4
  %c = alloca i32, align 4
  %f_ptr = alloca i32 (i32, i32)*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %c, metadata !31, metadata !DIExpression()), !dbg !32
  store i32 10, i32* %c, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %f_ptr, metadata !33, metadata !DIExpression()), !dbg !35
  store i32 (i32, i32)* @f1, i32 (i32, i32)** %f_ptr, align 8, !dbg !36
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %f_ptr, align 8, !dbg !37
  %1 = load i32, i32* %c, align 4, !dbg !38
  %call = call i32 %0(i32 %1, i32 20), !dbg !37
  store i32 %call, i32* %c, align 4, !dbg !39
  %2 = load i32, i32* %c, align 4, !dbg !40
  %cmp = icmp eq i32 %2, 30, !dbg !41
  %conv = zext i1 %cmp to i32, !dbg !41
  %call1 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !42
  store i32 (i32, i32)* @f2, i32 (i32, i32)** %f_ptr, align 8, !dbg !43
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %f_ptr, align 8, !dbg !44
  %4 = load i32, i32* %c, align 4, !dbg !45
  %call2 = call i32 %3(i32 %4, i32 20), !dbg !44
  store i32 %call2, i32* %c, align 4, !dbg !46
  %5 = load i32, i32* %c, align 4, !dbg !47
  %cmp3 = icmp eq i32 %5, 10, !dbg !48
  %conv4 = zext i1 %cmp3 to i32, !dbg !48
  %call5 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv4), !dbg !49
  ret i32 0, !dbg !50
}

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "akash_simple_fuc_ptr/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "f1", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 3, column: 12, scope: !7)
!13 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!14 = !DILocation(line: 3, column: 19, scope: !7)
!15 = !DILocation(line: 5, column: 10, scope: !7)
!16 = !DILocation(line: 5, column: 12, scope: !7)
!17 = !DILocation(line: 5, column: 11, scope: !7)
!18 = !DILocation(line: 5, column: 3, scope: !7)
!19 = distinct !DISubprogram(name: "f2", scope: !1, file: !1, line: 8, type: !8, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DILocalVariable(name: "a", arg: 1, scope: !19, file: !1, line: 8, type: !10)
!21 = !DILocation(line: 8, column: 12, scope: !19)
!22 = !DILocalVariable(name: "b", arg: 2, scope: !19, file: !1, line: 8, type: !10)
!23 = !DILocation(line: 8, column: 19, scope: !19)
!24 = !DILocation(line: 10, column: 10, scope: !19)
!25 = !DILocation(line: 10, column: 12, scope: !19)
!26 = !DILocation(line: 10, column: 11, scope: !19)
!27 = !DILocation(line: 10, column: 3, scope: !19)
!28 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !29, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!10}
!31 = !DILocalVariable(name: "c", scope: !28, file: !1, line: 15, type: !10)
!32 = !DILocation(line: 15, column: 9, scope: !28)
!33 = !DILocalVariable(name: "f_ptr", scope: !28, file: !1, line: 16, type: !34)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!35 = !DILocation(line: 16, column: 11, scope: !28)
!36 = !DILocation(line: 17, column: 11, scope: !28)
!37 = !DILocation(line: 18, column: 9, scope: !28)
!38 = !DILocation(line: 18, column: 15, scope: !28)
!39 = !DILocation(line: 18, column: 7, scope: !28)
!40 = !DILocation(line: 19, column: 12, scope: !28)
!41 = !DILocation(line: 19, column: 14, scope: !28)
!42 = !DILocation(line: 19, column: 5, scope: !28)
!43 = !DILocation(line: 20, column: 11, scope: !28)
!44 = !DILocation(line: 21, column: 9, scope: !28)
!45 = !DILocation(line: 21, column: 15, scope: !28)
!46 = !DILocation(line: 21, column: 7, scope: !28)
!47 = !DILocation(line: 22, column: 12, scope: !28)
!48 = !DILocation(line: 22, column: 14, scope: !28)
!49 = !DILocation(line: 22, column: 5, scope: !28)
!50 = !DILocation(line: 23, column: 5, scope: !28)

; ModuleID = 'equality_through_struct4_fail/main.c'
source_filename = "equality_through_struct4_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.str = type { i32, i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @pass_through_struct(%struct.str* %s, i32 %q) #0 !dbg !7 {
entry:
  %s.addr = alloca %struct.str*, align 8
  %q.addr = alloca i32, align 4
  store %struct.str* %s, %struct.str** %s.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.str** %s.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 %q, i32* %q.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %q.addr, metadata !19, metadata !DIExpression()), !dbg !20
  %0 = load i32, i32* %q.addr, align 4, !dbg !21
  %1 = load %struct.str*, %struct.str** %s.addr, align 8, !dbg !22
  %x = getelementptr inbounds %struct.str, %struct.str* %1, i32 0, i32 0, !dbg !23
  store i32 %0, i32* %x, align 4, !dbg !24
  %2 = load %struct.str*, %struct.str** %s.addr, align 8, !dbg !25
  %x1 = getelementptr inbounds %struct.str, %struct.str* %2, i32 0, i32 0, !dbg !26
  %3 = load i32, i32* %x1, align 4, !dbg !26
  %4 = load %struct.str*, %struct.str** %s.addr, align 8, !dbg !27
  %y = getelementptr inbounds %struct.str, %struct.str* %4, i32 0, i32 1, !dbg !28
  store i32 %3, i32* %y, align 4, !dbg !29
  %5 = load %struct.str*, %struct.str** %s.addr, align 8, !dbg !30
  %y2 = getelementptr inbounds %struct.str, %struct.str* %5, i32 0, i32 1, !dbg !31
  %6 = load i32, i32* %y2, align 4, !dbg !31
  %7 = load %struct.str*, %struct.str** %s.addr, align 8, !dbg !32
  %z = getelementptr inbounds %struct.str, %struct.str* %7, i32 0, i32 2, !dbg !33
  store i32 %6, i32* %z, align 4, !dbg !34
  ret void, !dbg !35
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !36 {
entry:
  %retval = alloca i32, align 4
  %q = alloca i32, align 4
  %s = alloca %struct.str, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %q, metadata !39, metadata !DIExpression()), !dbg !40
  call void @llvm.dbg.declare(metadata %struct.str* %s, metadata !41, metadata !DIExpression()), !dbg !42
  %0 = load i32, i32* %q, align 4, !dbg !43
  call void @pass_through_struct(%struct.str* %s, i32 %0), !dbg !44
  %1 = load i32, i32* %q, align 4, !dbg !45
  %z = getelementptr inbounds %struct.str, %struct.str* %s, i32 0, i32 2, !dbg !46
  %2 = load i32, i32* %z, align 4, !dbg !46
  %cmp = icmp ne i32 %1, %2, !dbg !47
  br i1 %cmp, label %lor.end, label %lor.rhs, !dbg !48

lor.rhs:                                          ; preds = %entry
  %y = getelementptr inbounds %struct.str, %struct.str* %s, i32 0, i32 1, !dbg !49
  %3 = load i32, i32* %y, align 4, !dbg !49
  %z1 = getelementptr inbounds %struct.str, %struct.str* %s, i32 0, i32 2, !dbg !50
  %4 = load i32, i32* %z1, align 4, !dbg !50
  %cmp2 = icmp ne i32 %3, %4, !dbg !51
  br label %lor.end, !dbg !48

lor.end:                                          ; preds = %lor.rhs, %entry
  %5 = phi i1 [ true, %entry ], [ %cmp2, %lor.rhs ]
  %lor.ext = zext i1 %5 to i32, !dbg !48
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %lor.ext), !dbg !52
  ret i32 1, !dbg !53
}

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "equality_through_struct4_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "pass_through_struct", scope: !1, file: !1, line: 8, type: !8, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !14}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "str", file: !1, line: 1, size: 96, elements: !12)
!12 = !{!13, !15, !16}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !11, file: !1, line: 3, baseType: !14, size: 32)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !11, file: !1, line: 4, baseType: !14, size: 32, offset: 32)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !11, file: !1, line: 5, baseType: !14, size: 32, offset: 64)
!17 = !DILocalVariable(name: "s", arg: 1, scope: !7, file: !1, line: 8, type: !10)
!18 = !DILocation(line: 8, column: 39, scope: !7)
!19 = !DILocalVariable(name: "q", arg: 2, scope: !7, file: !1, line: 8, type: !14)
!20 = !DILocation(line: 8, column: 46, scope: !7)
!21 = !DILocation(line: 10, column: 10, scope: !7)
!22 = !DILocation(line: 10, column: 3, scope: !7)
!23 = !DILocation(line: 10, column: 6, scope: !7)
!24 = !DILocation(line: 10, column: 8, scope: !7)
!25 = !DILocation(line: 11, column: 10, scope: !7)
!26 = !DILocation(line: 11, column: 13, scope: !7)
!27 = !DILocation(line: 11, column: 3, scope: !7)
!28 = !DILocation(line: 11, column: 6, scope: !7)
!29 = !DILocation(line: 11, column: 8, scope: !7)
!30 = !DILocation(line: 12, column: 10, scope: !7)
!31 = !DILocation(line: 12, column: 13, scope: !7)
!32 = !DILocation(line: 12, column: 3, scope: !7)
!33 = !DILocation(line: 12, column: 6, scope: !7)
!34 = !DILocation(line: 12, column: 8, scope: !7)
!35 = !DILocation(line: 14, column: 1, scope: !7)
!36 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !37, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!37 = !DISubroutineType(types: !38)
!38 = !{!14}
!39 = !DILocalVariable(name: "q", scope: !36, file: !1, line: 18, type: !14)
!40 = !DILocation(line: 18, column: 7, scope: !36)
!41 = !DILocalVariable(name: "s", scope: !36, file: !1, line: 20, type: !11)
!42 = !DILocation(line: 20, column: 14, scope: !36)
!43 = !DILocation(line: 22, column: 26, scope: !36)
!44 = !DILocation(line: 22, column: 3, scope: !36)
!45 = !DILocation(line: 24, column: 10, scope: !36)
!46 = !DILocation(line: 24, column: 17, scope: !36)
!47 = !DILocation(line: 24, column: 12, scope: !36)
!48 = !DILocation(line: 24, column: 19, scope: !36)
!49 = !DILocation(line: 24, column: 24, scope: !36)
!50 = !DILocation(line: 24, column: 31, scope: !36)
!51 = !DILocation(line: 24, column: 26, scope: !36)
!52 = !DILocation(line: 24, column: 3, scope: !36)
!53 = !DILocation(line: 26, column: 3, scope: !36)

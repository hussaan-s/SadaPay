
import Combine

public typealias AnyPublisherErrorless<Element> = AnyPublisher<Element, Never>
public typealias CurrentValueSubjectErrorless<Element> = CurrentValueSubject<Element, Never>
public typealias PassthroughValueSubjectErrorless<Element> = PassthroughSubject<Element, Never>
